import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../../data/data_source/remot/firebase_manager.dart';

class AddInvoiceVM {




  Future<String> addInvoice(
      {BuildContext? context,
      File? image,
      String? imagePath,
      String? clientName,
      double? total,
      double? deptTotal,
      String? notes,
      bool? isDelivered,
      DateTime? date}) async {
    String imageUrl =
    await FirebaseHelper().uploadImageOnFirebaseStorage(image!, imagePath!);
    String id= await FirebaseHelper().addInvoiceToFirebase(
      clientName: clientName ?? '',
      total: total!,
      deptTotal: deptTotal!,
      date: date!,
      imageUrl: imageUrl,
      isDelivered:isDelivered! ,
      notes: notes??''
    );
    debugPrint(imageUrl);
    return id;

  }
}
