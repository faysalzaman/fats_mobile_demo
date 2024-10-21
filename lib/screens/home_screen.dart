import 'dart:io';

import 'package:fats_mobile_demo/constants.dart';
import 'package:fats_mobile_demo/screens/AssetByCustodian/asset_by_custodian_screen.dart';
import 'package:fats_mobile_demo/screens/AssetByLocation/asset_by_location_screen.dart';
import 'package:fats_mobile_demo/screens/AssetTransaction/asset_inventory.dart';
import 'package:fats_mobile_demo/screens/Receiving/receiving_screen.dart';
import 'package:fats_mobile_demo/screens/AssetTransaction/asset_transaction.dart';
import 'package:fats_mobile_demo/screens/AssetVarification/asset_tag_information.dart';
import 'package:fats_mobile_demo/screens/NewAssetGenerateTag/new_asset_generate_tag_screen.dart';
import 'package:fats_mobile_demo/screens/VarifiedAsset/varified_asset_screen.dart';
import 'package:fats_mobile_demo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AssetCapture/asset_location_form_screen.dart';
import 'AssetForPrinting/AssetForPrintingScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {
    "onTap": [
      () {
        Get.to(() => const AssetLocationFormScreen());
      },
      () {
        Get.to(() => const NewAssetGenerateTagScreen());
      },
      () {
        Get.to(() => const AssetForPrintingScreen());
      },
      () {
        Get.to(() => const VarifiedAssetScreen());
      },
      () {
        Get.to(() => const ReceivingScreen());
      },
      () {
        Get.to(() => const AssetByCustodian());
      },
      () {
        Get.to(() => const AssetByLocationScreen());
      },
      () {
        Get.to(() => const AssetTransaction());
        // Get.snackbar(
        //   "Coming Soon",
        //   "This feature is coming soon",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.grey,
        //   colorText: Colors.white,
        // );
      },
      () {
        Get.snackbar(
          "Coming Soon",
          "This feature is coming soon",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      },
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        Get.offAll(const LoginScreen());
        Get.snackbar(
          "Logout",
          "You have been logged out successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
      () {
        Get.snackbar(
          "Coming Soon",
          "This feature is coming soon",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      },
      () {
        Get.to(() => const AssetTagInformation());
      },
    ],
    "icons": [
      "assets/asset_capture.png",
      "assets/new_asset.png",
      "assets/asset_for_printing.png",
      "assets/varified_asset.png",
      "assets/asset_movement.png",
      "assets/asset_custodian.png",
      "assets/asset_by_location.png",
      "assets/asset_inverntory.png",
      "assets/admin_panel.png",
      "assets/logout.png",
      "assets/find_asset.png",
      "assets/asset_verification.png",
    ],
  };

  String userName = '';
  String userEmail = '';
  String token = '';

  List<String> icons = [
    "assets/images/AssetCapture.png",
    "assets/images/NewAssetGenerateTags.png",
    "assets/images/AssetPrintBarcodes.png",
    "assets/images/VerifyAssets.png",
    "assets/images/AssetMovements.png",
    "assets/images/AssetCustodian.png",
    "assets/images/AssetLocations.png",
    "assets/images/AssetTransactions.png",
    "assets/images/AdminSettings.png",
    "assets/images/Logout.png",
    "assets/images/FindAssets.png",
    "assets/images/AssetVerification.png",
  ];
  List<String> names = [
    "Asset Capture",
    "New Asset\n(Generate Tags)",
    "Asset for Printing",
    "Verified Asset",
    "Receiving",
    "Asset By Custodian",
    "Assets By Location",
    "Asset Transaction",
    "Admin Panel",
    "Logout",
    "Find Asset",
    "Asset Verification",
  ];

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
      token = prefs.getString('token') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // show the dialog to back or not

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: const Text("Do you want to exit an App"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text("Yes"),
              ),
            ],
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            // show the drawer icon to open the drawer
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                // open the drawer
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Constant.primaryColor,
              statusBarIconBrightness: Brightness.light,
            ),

            flexibleSpace: Container(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              // height: 170,
              decoration: BoxDecoration(
                color: Constant.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Material(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: Constant.primaryColor,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "FATS",
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: FittedBox(
                          child: Text(
                            "Fixed Asset Tracking Software v.2.0",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: MyDrawerWidget(
          userName: userName,
          userEmail: userEmail,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(
                    icons.length,
                    (index) {
                      return ItemWidget(
                        title: names[index],
                        icon: icons[index],
                        onTap: data["onTap"][index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // child: Row(
          //   children: [
          //     Column(
          //       children: [
          //         Expanded(
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(
          //               vertical: 10,
          //               horizontal: 5,
          //             ),
          //             width: 60,
          //             height: double.infinity,
          //             color: Constant.primaryColor,
          //             child: SingleChildScrollView(
          //               child: Column(
          //                 children: List.generate(
          //                   icons.length,
          //                   (index) {
          //                     return Container(
          //                       padding:
          //                           const EdgeInsets.symmetric(horizontal: 5),
          //                       child: GestureDetector(
          //                         onTap: data["onTap"][index],
          //                         child: Column(
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.center,
          //                           children: [
          //                             CircleAvatar(
          //                               radius: 30,
          //                               backgroundColor: Colors.white,
          //                               child: Image.asset(
          //                                 data["icons"][index],
          //                                 fit: BoxFit.contain,
          //                                 width: 30,
          //                               ),
          //                             ),
          //                             const SizedBox(height: 3),
          //                             Text(
          //                               names[index],
          //                               style: const TextStyle(
          //                                 color: Colors.white,
          //                                 fontSize: 7,
          //                               ),
          //                               textAlign: TextAlign.center,
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     );
          //                   },
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           width: 60,
          //           color: Constant.primaryColor,
          //           child: IconButton(
          //             onPressed: () {
          //               _scaffoldKey.currentState!.openDrawer();
          //             },
          //             icon: const Icon(
          //               Icons.double_arrow,
          //               color: Colors.white,
          //               size: 20,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Expanded(
          //       child: Column(
          //         children: [
          //           Container(
          //             decoration: const BoxDecoration(
          //               color: Constant.primaryColor,
          //             ),
          //             padding: const EdgeInsets.only(bottom: 10),
          //             width: double.infinity,
          //             child: Column(
          //               children: const <Widget>[
          //                 Text(
          //                   "FATS",
          //                   style: TextStyle(
          //                     fontSize: 60,
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: EdgeInsets.only(left: 10.0, right: 10.0),
          //                   child: FittedBox(
          //                     child: Text(
          //                       "Fixed Asset Tracking Software v.2.0",
          //                       style: TextStyle(
          //                         color: Colors.white,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             child: GridView.count(
          //               crossAxisCount: 2,
          //               childAspectRatio: 1.5,
          //               crossAxisSpacing: 10,
          //               mainAxisSpacing: 5,
          //               physics: const BouncingScrollPhysics(),
          //               children: List.generate(
          //                 icons.length,
          //                 (index) {
          //                   return ItemWidget(
          //                     title: names[index],
          //                     icon: icons[index],
          //                     onTap: data["onTap"][index],
          //                   );
          //                 },
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}

class MyDrawerWidget extends StatefulWidget {
  final String userName;
  final String userEmail;

  const MyDrawerWidget({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<MyDrawerWidget> createState() => _MyDrawerWidgetState();
}

class _MyDrawerWidgetState extends State<MyDrawerWidget> {
  Map<String, dynamic> data = {
    "name": [
      "Asset Capture",
      "New Asset\n(Generate Tags)",
      "Asset for Printing",
      "Verified Asset",
      "Receiving",
      "Asset By Custodian",
      "Assets By Location",
      "Asset Inventory",
      "Admin Panel",
      "Logout",
      "Find Asset",
      "Asset Verification",
    ],
    "icon": [
      "assets/images/AssetCapture.png",
      "assets/images/NewAssetGenerateTags.png",
      "assets/images/AssetPrintBarcodes.png",
      "assets/images/VerifyAssets.png",
      "assets/images/AssetMovements.png",
      "assets/images/AssetCustodian.png",
      "assets/images/AssetLocations.png",
      "assets/images/AssetTransactions.png",
      "assets/images/AdminSettings.png",
      "assets/images/Logout.png",
      "assets/images/FindAssets.png",
      "assets/images/AssetVerification.png",
    ],
    "onTap": [
      () {
        Get.to(() => const AssetLocationFormScreen());
      },
      () {
        Get.to(() => const NewAssetGenerateTagScreen());
      },
      () {
        Get.to(() => const AssetForPrintingScreen());
      },
      () {
        Get.to(() => const VarifiedAssetScreen());
      },
      () {
        Get.to(() => const ReceivingScreen());
      },
      () {
        Get.to(() => const AssetByCustodian());
      },
      () {
        Get.to(() => const AssetByLocationScreen());
      },
      () {
        // Asset Inventory
        Get.to(() => const AssetsInventory());
      },
      () {
        // Admin Panel
        Get.snackbar(
          "Coming Soon",
          "This feature is coming soon",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      },
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        Get.offAll(const LoginScreen());
        Get.snackbar(
          "Logout",
          "You have been logged out successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
      () {
        // Find Asset
        Get.snackbar(
          "Coming Soon",
          "This feature is coming soon",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      },
      () {
        Get.to(() => const AssetTagInformation());
      },
    ]
  };
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Constant.primaryColor,
              ),
              accountName: Text(widget.userName),
              accountEmail: Text(widget.userEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  widget.userName[1],
                  style: const TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            for (var i = 0; i < data["name"].length; i++)
              ListTile(
                leading: Image.asset(
                  data["icon"][i],
                  height: 40,
                  width: 30,
                ),
                title: Text(
                  data["name"][i],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: data["onTap"][i],
              ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemWidget extends StatefulWidget {
  String title;
  String icon;
  VoidCallback onTap;

  ItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.white,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
          shadowColor: Constant.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                widget.icon.toString(),
                height: 70,
                width: 70,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
