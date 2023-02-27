import 'package:elnemr_invoice/core/colors.dart';
import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/screens/login&Reg/widgets.dart';
import 'package:flutter/material.dart';
import '../../data/data_source/remot/firebase_auth.dart';
import '../shared.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  LabeledGlobalKey<FormState> formKeyReg = LabeledGlobalKey<FormState>('login');
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  final confirmPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //bool loading = false;
    debugPrint('---> Current User =${currentUser.toString()}');
    var textTheme = Theme.of(context).textTheme;

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
                    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 12),
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.5,
                      height: MediaQuery.of(context).size.height * 0.65,
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
                            Text(
                              AppStrings.signUp,
                              style: textTheme.headline1,
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Form(
                              key: formKeyReg,
                              child: Column(
                                children: [
                                  TextFormField(
                                      key: const Key('eMail'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'First Enter Email';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailcon,
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                      )),
                                  TextFormField(
                                    key: const Key('Pass'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'First Enter Password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    controller: passwordcon,
                                    decoration: const InputDecoration(
                                      hintText: "Password",
                                    ),
                                  ),
                                  TextFormField(
                                    key: const Key('conPass'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'First Enter Password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    controller: confirmPass,
                                    decoration: const InputDecoration(
                                      hintText: "Confirm Password",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 55,
                            ),
                            Roundbutton(
                                key: const Key('signUp'),
                                title: AppStrings.sign,
                                tapfun: () async {
                                  if (formKeyReg.currentState!.validate()) {
                                    debugPrint("press signup");
                                    showLoading(context, 'جاري تسجيل حسابك');
                                    bool user = await userReg(context,
                                        emailcon.text, passwordcon.text);
                                        //hideLoading(context);
                                    if (user != false) {
                                      // ignore: use_build_context_synchronously
                                     // hideLoading(context);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const Loginscreen(),
                                      ));
                                      // ignore: use_build_context_synchronously
                                      //hideLoading(context);
                                      showSnakBarSuccess(context,
                                          'تم التسجيل بنجاح', greenColor);
                                    }
                                  }
                                }),
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
                        key: const Key('bottomRow'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Loginscreen()));
                              },
                              child: const Text("Login")),
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
