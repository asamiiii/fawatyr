import 'package:flutter/cupertino.dart';

class DeptProvider extends ChangeNotifier{
  double totalDept=0;

  deptSum(double value,double deptMinus){
    totalDept= deptMinus-value;
    notifyListeners();
    return totalDept;
  }
}