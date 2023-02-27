import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/core/theme.dart';
import 'package:elnemr_invoice/data/data_source/local/shared_pref.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_auth.dart';
import 'package:elnemr_invoice/screens/dept_history_screen/dept_provider.dart';
import 'package:elnemr_invoice/screens/home_screen/home_provider.dart';
import 'package:elnemr_invoice/screens/home_screen/home_screen.dart';
import 'package:elnemr_invoice/screens/login&Reg/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CashHelper.init();
  runApp(const MyApp());
  MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (context) => HomeProvider(),),
    ChangeNotifierProvider(create: (context) => DeptProvider(),),

  ],
  
  child:const MyApp() ,);

   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
 ));
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeptProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: theme,
          home: currentUser !=null ? const HomePage(): const Loginscreen(),
      
      ),
    );
  }
}

