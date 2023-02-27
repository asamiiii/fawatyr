import 'package:elnemr_invoice/core/colors.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/screens/dept_history_screen/dept_widgets.dart';
import 'package:flutter/material.dart';
import 'package:elnemr_invoice/screens/detailes_screen/detailes_widgets.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DeptHistory extends StatelessWidget {
  String docId;
  DeptHistory({
    Key? key,
    required this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseHelper().getDeptHistory(docId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: CircularProgressIndicator());
          }
          var list = snapshot.data!.docs;
          
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: DetailesAppBar(
                  clientName: 'باقي ${list[0].data()!.dept.toString()} ج'),
            ),
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                   String formattedDate = DateFormat.yMMMEd().format(list[index].data()!.date!);
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: gray,
                        child: Column(
                          children: [
                            Text(
                              'تم دفع ${list[index].data()!.done.toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                      decoration: index != 0
                                          ? TextDecoration.lineThrough
                                          : null),
                            ),
                            Text('متبقي ${list[index].data()!.dept.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                        color: redColor,
                                        decoration: index != 0
                                            ? TextDecoration.lineThrough
                                            : null)),
                            Text(formattedDate)
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: list.length),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: greenColor,
              onPressed: () {
                showBottomSheetTask(context, docId,
                    double.parse(list[0].data()!.dept.toString()));
              },
              label: const Text('سداد مبلغ'),
            ),
          );
        });
  }
}
