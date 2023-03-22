import 'package:elnemr_invoice/core/colors.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/screens/home_screen/home_screen.dart';
import 'package:elnemr_invoice/screens/login&Reg/reg_screen.dart';
import 'package:elnemr_invoice/screens/login&Reg/widgets.dart';
import 'package:flutter/material.dart';
import '../../data/data_source/local/shared_pref.dart';
import '../../data/data_source/remot/firebase_auth.dart';
import '../shared.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {

  bool loading = false;
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  LabeledGlobalKey<FormState> formkey = LabeledGlobalKey<FormState>('login');
  @override
  Widget build(BuildContext context) {
    debugPrint('---> Current User = ${currentUser.toString()}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
                color: nemrYellow,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(
                    child: Text(
                      "Fawatyr",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 30),
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: const Key('mail'),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'Enter Email';
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailcon,
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                      )),
                                  TextFormField(
                                    key: const Key('pass'),
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'Enter Password';
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                    keyboardType: TextInputType.emailAddress,
                                    controller: passwordcon,
                                    decoration: const InputDecoration(
                                      hintText: "Password",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      /*Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  forgetpassword())
                                                  );*/
                                    },
                                    child: const Text(
                                      "Forgot password?",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Roundbutton(
                                title: "Login",
                                tapfun: () async{
                                  showLoading(context,'محاولة التسجيل');
                                  bool user =await userLogin(
                                      context: context,
                                      emailAddress: emailcon.text,
                                      password: passwordcon.text);

                                      if(user!=false){
                                        // ignore: use_build_context_synchronously
                                        hideLoading(context);
                                        FirebaseHelper.collectionName= emailcon.text;
                                        CashHelper.addToLocal(emailcon.text);
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage(),));
                                        showSnakBarSuccess(context, 'تم تسجيل الدخول بنجاح', greenColor);
                                      }
                                      //hideLoading(context);
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
            padding: const EdgeInsets.all(30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "Don't have an account",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));

                      },
                      child: const Text("Sign Up")),
                ],
              ),
            ),
          ),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
