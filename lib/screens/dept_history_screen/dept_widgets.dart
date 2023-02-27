import 'package:elnemr_invoice/core/colors.dart';
import 'package:elnemr_invoice/screens/dept_history_screen/dept_provider.dart';
import 'package:elnemr_invoice/screens/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/strings.dart';
import '../../data/data_source/remot/firebase_manager.dart';

Future showBottomSheetTask(
  BuildContext context,
  String docId,
  double dept,
) {
  TextEditingController? deptController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var myProvider = Provider.of<DeptProvider>(context, listen: false);
  //myProvider.totalDept = dept;
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (context) => DeptProvider(),
          child: Consumer<DeptProvider>(builder: (context, value, child) {
            return Material(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      AppStrings.doneDept,
                      style: Theme.of(context).textTheme.headline1,
                    )),
                    Row(
                      children: [
                        Text(
                          value.totalDept.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(
                                  color: value.totalDept.isNegative
                                      ? redColor
                                      : blackColor),
                        ),
                        Text(
                          AppStrings.invoiceDept,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                onChanged: (valuee) {
                                  value.deptSum(
                                      double.parse(
                                          valuee.isEmpty ? '0' : valuee),
                                      dept);
                                },
                                controller: deptController,
                                autofocus: true,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                textDirection: TextDirection.rtl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  filled: true,
                                  fillColor: whiteColor,
                                  prefixIcon: const Icon(
                                      Icons.monetization_on_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  hintText: '',
                                  hintTextDirection: TextDirection.rtl,
                                  hintStyle: GoogleFonts.notoKufiArabic(
                                    color: Colors.black,
                                  ),

                                  //labelStyle: TextStyle(color: blackColor)),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          showLoading(context, 'يتم السداد ');
                          if (formKey.currentState!.validate()) {
                            double x = myProvider.deptSum(
                                double.parse(deptController.text), dept);
                            await FirebaseHelper().addDeptToFirebase(
                                id: docId,
                                dept: x,
                                done: double.parse(deptController.text));
                            await FirebaseHelper()
                                .updateDeptTotal(docId, x)
                                .then((value) {
                              hideLoading(context);
                              hideLoading(context);
                              showSnakBarSuccess(
                                  context, 'تم سداد المبلغ بنجاح', greenColor);
                            });
                          }
                        },
                        child: const Text('خصم المبلغ المسدد'))
                  ],
                ),
              ),
            );
          }),
        );
      }).then((value) => debugPrint(value));
}
