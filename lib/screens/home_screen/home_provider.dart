

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elnemr_invoice/data/models/invoice_model.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier{

  double totalDept=0;
 

    void calculateTotal(QuerySnapshot<Invoice?> snapshot) {
    double total = 0.0;

    for (var document in snapshot.docs) {
      double field = document.data()!.deptTotal!;
      total += field;
    }

    totalDept = total;
    notifyListeners();
  }
   
  }
