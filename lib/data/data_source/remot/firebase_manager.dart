import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/dept_model.dart';
import '../../models/invoice_model.dart';

class FirebaseHelper {
  static String? collectionName;

  CollectionReference getInvoiceCollection() {
    return FirebaseFirestore.instance
        .collection(collectionName!)
        .withConverter<Invoice>(
          fromFirestore: (snapshot, _) => Invoice.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  Future<String> addInvoiceToFirebase(
      {String? id,
      required String clientName,
      required double total,
      required double deptTotal,
      required String imageUrl,
      required String notes,
      required bool isDelivered,
      required DateTime date}) async {
    var collection = getInvoiceCollection();
    var docRef = collection.doc();
     await docRef.set(Invoice(
        id: docRef.id,
        name: clientName,
        total: total,
        deptTotal: deptTotal,
        imageUrl: imageUrl,
        isDelivered: isDelivered,
        notes: notes,
        date: date));
        return docRef.id;
  }

  Future<String> uploadImageOnFirebaseStorage(
      File imageFile, String path) async {
    String? url;
// Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();
// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child(p.basename(path));

    try {
      await mountainsRef.putFile(imageFile);
      url = await mountainsRef.getDownloadURL();
    } catch (e) {
      //
    }
    debugPrint('--> url : $url');
    return url ?? '';
  }

  Stream<QuerySnapshot<Invoice?>> getInvoicesFromFirestore() {
    Stream<QuerySnapshot<Invoice?>> querySnapshot = getInvoiceCollection()
        .orderBy('date', descending: true)
        .snapshots() as Stream<QuerySnapshot<Invoice?>>;
    // Get data from docs and convert map to List

    return querySnapshot;
  }

  Future<QuerySnapshot<Invoice>> seaechInvoicesFromFirestore(
      String searchWord) async {
    QuerySnapshot<Invoice> querySnapshot = await getInvoiceCollection()
        .where('name', isGreaterThanOrEqualTo: searchWord)
        .get() as QuerySnapshot<Invoice>;
    // Get data from docs and convert map to List
    return querySnapshot;
  }

  Future<void> deleteUser(String? taskId, String url) async {
    var collection = getInvoiceCollection();
    var docRef = collection.doc(taskId);
    url!='' ? await deleteImageFromCloud(url):null;    //! delete this image from FireBase Cloud .
    await deleteDept(taskId);           //! delete Dept collection related this document .
    return docRef
        .delete()
        .then((value) => debugPrint("User Deleted"))
        .catchError((error) => debugPrint("Failed to delete user: $error"));
  }

  deleteImageFromCloud(String url) {
    FirebaseStorage.instance.refFromURL(url).delete();
  }

  Future<void> updateTask(String taskId, Invoice invoice) {
    var collection = getInvoiceCollection();
    var docRef = collection.doc(taskId);
    return docRef.update({
      'name': invoice.name,
      'total': invoice.total,
      'imageUrl': invoice.imageUrl,
      'notes': invoice.notes,
      'isDelivered': invoice.isDelivered,
    });
  }

  Future<void> updateDeptTotal(String taskId, double deptTotal) {
    var collection = getInvoiceCollection();
    var docRef = collection.doc(taskId);
    return docRef.update({
      'deptTotal': deptTotal,
    });
  }
  //! Dept FireBase Oprations
 
  CollectionReference getDeptCollection(String id) {
    return getInvoiceCollection().doc(id).collection('dept').withConverter<Dept>(
          fromFirestore: (snapshot, _) => Dept.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  addDeptToFirebase({String? id, double? done, double? dept}) {
    var collection = getDeptCollection(id!);
    var docRef = collection.doc();
    return docRef.set(Dept(
      id: docRef.id,
      done: done!,
      dept: dept!,
      date: DateTime.now()
    ));
  }

  Stream<QuerySnapshot<Dept?>> getDeptHistory(String id){
    Stream<QuerySnapshot<Dept?>> querySnapshot = getDeptCollection(id)
        .orderBy('date', descending: true)
        .snapshots() as Stream<QuerySnapshot<Dept?>>;

        return querySnapshot;
  }

   Future<void> deleteDept(String? deptId) async {
    var collection = getDeptCollection(deptId!);
    var docRef = collection.doc();
    
     docRef
        .delete()
        .then((value) => debugPrint("User Deleted"))
        .catchError((error) => debugPrint("Failed to delete user: $error"));
  }



Future<QuerySnapshot<Invoice>> getAllDoneInvoices() async {
    QuerySnapshot<Invoice> querySnapshot = await getInvoiceCollection()
        .where('deptTotal', isLessThanOrEqualTo: 0.0)
        .get() as QuerySnapshot<Invoice>;
    // Get data from docs and convert map to List
    return querySnapshot;
  }


  
}
