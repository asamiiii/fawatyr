import 'dart:io';
import 'package:elnemr_invoice/core/colors.dart';
import 'package:elnemr_invoice/data/data_source/local/shared_pref.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_auth.dart';
import 'package:elnemr_invoice/screens/home_screen/home_provider.dart';
import 'package:elnemr_invoice/screens/shared.dart';
import 'package:path/path.dart' as p;
import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/screens/detailes_screen/detailes_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../add_invoice_screen/add_inv_without_image.dart';
import '../add_invoice_screen/add_invoice_screen.dart';
import 'home_widgets.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
   const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


@override
  void initState() {
    FirebaseHelper.collectionName= CashHelper.getFromLocal();
   // userName=currentUser!.displayName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('---> Current User = ${currentUser.toString()}');
    return ChangeNotifierProvider(
        create: (context) => HomeProvider(),
        builder: (context, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: HomeAppBar(),
            ),
            body: StreamBuilder(
                stream: FirebaseHelper().getInvoicesFromFirestore(),
                builder: (context, snapshot) {
                  var list = snapshot.data?.docs;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (list!.isEmpty) {
                    return Center(child: Text(AppStrings.noInvoiceExist));
                  } else if (snapshot.hasError) {
                    return Center(child: Text(AppStrings.hasErrorMessage));
                  }
                  //!Calculate total Depts
                  Future.delayed(Duration.zero, () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .calculateTotal(snapshot.data!);
                  });

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailesScreen(
                                      invoice: list[index].data()),
                                ));
                              },
                              child: InvoiceItem(list[index].data()));
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 5),
                        itemCount: list.length),
                  );
                }),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Consumer<HomeProvider>(
                  builder: (context, value, child) => ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: redColor,
                          width: 200,
                          height: 50,
                          child: Center(
                              child: Text(
                            'الدين العام : ${value.totalDept.toString()}ج',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2,
                          )),
                        ),
                      )),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: Container(
              color: nemrYellow,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'dept',
                    label: Text(
                      'اضافةدين',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    icon: Icon(
                      Icons.add,
                      color: blackColor,
                    ),
                    backgroundColor: nemrYellow,
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddInvWithoutImage(),
                      ));
                    },
                  ),
                  FloatingActionButton.extended(
                    heroTag: 'add',
                    elevation: 0,
                    label: Text(
                      AppStrings.addInvoice,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    backgroundColor: nemrYellow,
                    onPressed: () async {
                      showLoading(context, 'يتم تجهيز الفاتورة');
                      final pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        imageQuality: 70,
                      );
                      // ignore: use_build_context_synchronously
                      hideLoading(context);
                      if (pickedFile != null) {
                        final imageFile = File(pickedFile.path);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddInoviceScreen(
                                  image: imageFile,
                                  imagePath: p.basename(pickedFile.path)),
                            ));
                      } else {
                        debugPrint('No image selected.');
                      }
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

/*Consumer<HomeProvider>(
                    builder: (context, value, child) => TotalContainer(
                        total: value.totalDept.toString(),
                        title: 'الدين العام',
                        color: gray))*/
