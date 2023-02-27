import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/strings.dart';
import '../../data/data_source/remot/firebase_manager.dart';
import '../shared.dart';

class AddInvWithoutImage extends StatefulWidget {
  const AddInvWithoutImage({super.key});

  @override
  State<AddInvWithoutImage> createState() => _AddInvWithoutImageState();
}

class _AddInvWithoutImageState extends State<AddInvWithoutImage> {
  TextEditingController? userNameController = TextEditingController();

  TextEditingController? totalInvoiceController = TextEditingController();

  TextEditingController? totalDeptController = TextEditingController();

  TextEditingController? invoiceNotesController = TextEditingController();
  bool isDelivered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40.0, left: 10, right: 10, bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 55,
                          padding: const EdgeInsets.only(top: 7),
                          child: AppTextField(
                            controller: userNameController!,
                            hintText: AppStrings.clientNameText,
                            icon: const Icon(Icons.person),
                            keyboardType: TextInputType.text,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 55,
                          padding: const EdgeInsets.only(top: 7),
                          child: AppTextField(
                            controller: totalDeptController!,
                            icon: const Icon(Icons.attach_money_outlined),
                            keyboardType: TextInputType.number,
                            hintText: AppStrings.doneDept,
                          )),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: Container(
                          height: 55,
                          padding: const EdgeInsets.only(top: 7),
                          child: AppTextField(
                            controller: totalInvoiceController!,
                            icon: const Icon(Icons.attach_money_outlined),
                            keyboardType: TextInputType.number,
                            hintText: AppStrings.invoiceTotal,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: AppTextField(
                        controller: invoiceNotesController!,
                        keyboardType: TextInputType.text,
                        icon: const Icon(Icons.edit),
                        maxLines: 4,
                        hintText: AppStrings.notesText,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.isDeliveredText,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Checkbox(
                      checkColor: Colors.greenAccent,
                      activeColor: Colors.red,
                      value: isDelivered,
                      onChanged: (value) {
                        isDelivered = value!;
                        debugPrint('$value');
                        setState(() {});
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      double totalDept =
                          double.parse(totalInvoiceController!.text) -
                              double.parse(totalDeptController!.text);
                      showLoading(context, 'جاري التحميل');
                      String id = await FirebaseHelper().addInvoiceToFirebase(
                        clientName: userNameController!.text,
                        imageUrl: '',
                        total: double.parse(totalInvoiceController!.text),
                        deptTotal: totalDept,
                        notes: invoiceNotesController!.text,
                        isDelivered: isDelivered,
                        date: DateTime.now(),
                      );

                      await FirebaseHelper().addDeptToFirebase(
                          id: id,
                          done: double.parse(totalDeptController!.text),
                          dept: totalDept);
                      // ignore: use_build_context_synchronously
                      hideLoading(context);
                      // ignore: use_build_context_synchronously
                      hideLoading(context);
                      // ignore: use_build_context_synchronously
                      showSnakBarSuccess(
                          context, AppStrings.successMessage, greenColor);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: const Text('اضافة الفاتورة')),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}
