import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    
  }
   //!Add colllection name to local storag (shared pref)
  static addToLocal(String value)async{
    await sharedPreferences?.setString('collection_mail', value);
  }

  static String getFromLocal(){
     String? prefValue = sharedPreferences?.getString('collection_mail');
     return prefValue!;
  }

  static removeFromLocal()async{
     await sharedPreferences?.remove('collection_mail');
  }
}