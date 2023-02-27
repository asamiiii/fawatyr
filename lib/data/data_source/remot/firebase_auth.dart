import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../core/strings.dart';
import '../../../screens/shared.dart';

FirebaseAuth credential = FirebaseAuth.instance;

User? currentUser = FirebaseAuth.instance.currentUser;

Future<bool> userReg(
    BuildContext context, String emailAddress, String password) async {
  debugPrint('context : $context');
  
  try {
    await credential.createUserWithEmailAndPassword(
      email: emailAddress.trim(),
      password: password,
    );
    //debugPrint('Success');
    //alertDialog(context,'Success','');
    
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      debugPrint('The password provided is too weak.');
      //const Center(child: Text('knkjhljh'));
      hideLoading(context);
      alertDialog(
          context: context,
          title: AppStrings.weekPassword,
          desc: AppStrings.weekPasswordDesc);
          return false;
    } else if (e.code == 'email-already-in-use') {
      debugPrint('The account already exists for that email.');
      //const Center(child: Text('knkjhljh'));
      hideLoading(context);
      alertDialog(context: context, title: AppStrings.emailIsExist, desc: '');
     return false;
    }
  } catch (e) {
    debugPrint('error ------> $e');
    return false;
    
    // ignore: dead_code
    hideLoading(context);
    alertDialog(context:context,title: AppStrings.emailIsExist,desc: e.toString());
  }
  return false;
}

Future<bool> userLogin(
    {required BuildContext context,
    required String emailAddress,
    required String password}) async {
       //bool user =false ;
  try {
      await credential.signInWithEmailAndPassword(
        email: emailAddress, password: password);
        return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      hideLoading(context);
      alertDialog(
          context: context,
          title: AppStrings.signInError,
          desc: AppStrings.signInNotFound);
         // hideLoading(context);
      debugPrint('No user found for that email.');
      return false;
    } else if (e.code == 'wrong-password') {
      hideLoading(context);
      alertDialog(
          context: context,
          title: AppStrings.signInPassError,
          desc: '');
          //hideLoading(context);
      debugPrint('Wrong password provided for that user.');
      return false;
    }
    //hideLoading(context);
    return false;
  }
}

alertDialog(
    {required BuildContext context,
    required String title,
    required String desc}) async {
  debugPrint('------> Alerted <------');
  await Alert(
    context: context,
    type: AlertType.error,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        width: 120,
        child: const Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  ).show();
}
