import 'package:cached_network_image/cached_network_image.dart';
import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/data/models/invoice_model.dart';
import 'package:elnemr_invoice/screens/dept_history_screen/dept_history.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../core/colors.dart';
import '../shared.dart';
import 'detailes_widgets.dart';

// ignore: must_be_immutable
class DetailesScreen extends StatelessWidget {
  final Invoice? invoice;

  DetailesScreen({super.key, required this.invoice});

  bool isImage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: DetailesAppBar(
            clientName: invoice!.name,
          )),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 130.0, left: 10, right: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  invoice!.imageUrl != ''
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) {
                              isImage = true;
                              return const Text('الفاتوره بدون صورة');
                            },
                            fadeInDuration: const Duration(seconds: 1),
                            imageUrl: invoice!.imageUrl,
                            //width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.height * 0.70,
                            fit: BoxFit.fill,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Table(
                    textDirection: TextDirection.rtl,
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        TableText(
                          txt: AppStrings.clientNameText,
                        ),
                        TableText(
                          txt: invoice!.name,
                        ),
                      ]),
                      TableRow(children: [
                        TableText(
                          txt: "حالة البضاعة",
                        ),
                        TableText(
                          txt: invoice!.isDelivered == true
                              ? AppStrings.isDeliveredTrue
                              : AppStrings.isDeliveredFalse,
                        )
                      ]),
                      TableRow(children: [
                        TableText(
                          txt: AppStrings.totalText,
                        ),
                        TableText(
                          txt: invoice!.total.toString(),
                        )
                      ]),
                      TableRow(children: [
                        TableText(
                          txt: AppStrings.invoiceDept,
                        ),
                        TableText(
                          txt: invoice!.deptTotal.toString(),
                        )
                      ]),
                      TableRow(children: [
                        TableText(
                          txt: AppStrings.notesText,
                        ),
                        TableText(
                          txt: invoice!.notes == ''
                              ? AppStrings.notesInvoiceisNotExist
                              : invoice!.notes,
                        )
                      ])
                    ],
                  ),
                  
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: FirebaseHelper().getDeptHistory(invoice!.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        var list = snapshot.data?.docs;
                        debugPrint(list.toString());
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TotalContainer(
                                total: list![0].data()!.dept.toString(),
                                title: AppStrings.invoiceDept,
                                color: redColor),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            greenColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DeptHistory(
                                            docId: invoice!.id!,
                                          )));

                                  //
                                },
                                child: Row(
                                  children: [
                                    Text(AppStrings.dept),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.history)
                                  ],
                                ))
                          ],
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    invoice?.notes == ''
                        ? AppStrings.notesInvoiceisNotExist
                        : invoice!.notes,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(overflow: TextOverflow.ellipsis),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () async {
                        await alertDialog(context,'تنبيه','هل انت متأكد من حذف الصورة ');

                        //
                      },
                      child: const Text('مسح الفاتورة'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  alertDialog(BuildContext context,String title,String desc) async {
    await Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          onPressed: () async {
            await FirebaseHelper().deleteDept(invoice!.id);
            await FirebaseHelper()
                .deleteUser(invoice!.id, invoice!.imageUrl)
                .then((value) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              showSnakBarSuccess(context, AppStrings.deleteMessage, redColor);
            });
          },
          width: 120,
          child: const Text(
            "حذف",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
}
