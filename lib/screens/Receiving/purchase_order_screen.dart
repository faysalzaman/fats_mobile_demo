// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously

import 'package:fats_mobile_demo/models/PODetailsModel.dart';
import 'package:fats_mobile_demo/models/POMasterModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Services/GetAllCategories/GetAllCategoriesServices.dart';
import '../../Services/GetBrand/GetBrandServices.dart';
import '../../Services/SendForBarCode/SendForBarCodeServices.dart';
import '../../constants.dart';
import '../../widgets/button_widget.dart';
import '../home_screen.dart';

class PurchaseOrderScreen extends StatefulWidget {
  final PODetailsModel poDetail;
  final POMasterModel poMaster;

  const PurchaseOrderScreen({
    Key? key,
    required this.poDetail,
    required this.poMaster,
  }) : super(key: key);

  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  TextEditingController filterByController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String _mCode = "";
  String _sCode = "";
  String mainDescription = "";
  String subDescription = "";

  String? selectCategory;
  var categoryList = [];

  String? selectBrand;
  var brandList = [];

  static List<String> brand = [];
  static List<String> model = [];
  static List<String> qty = [];
  static List<String> assetClass = [];
  static List<String> mCode = [];
  static List<String> sCode = [];
  static List<String> majorDescription = [];
  static List<String> minorDescription = [];

  static List<String> _tableBrand = [];

  Map<String, dynamic> record = {
    "brand": brand,
    "model": model,
    "qty": qty,
    "assetClass": assetClass,
    "mCode": mCode,
    "sCode": sCode,
    "majorDescription": majorDescription,
    "minorDescription": minorDescription,
  };

  @override
  void initState() {
    super.initState();

    qtyController.text = "1";

    Future.delayed(
      Duration.zero,
      () {
        Constant.showLoadingDialog(context);
        GetAllCategoriesServices.getAllCategories().then((value) {
          setState(() {
            selectCategory = value[0].subDescription.toString();
            for (var category in value) {
              categoryList.add(category.subDescription ?? "");
              mCode.add(category.mainCategoryCode ?? "");
              sCode.add(category.subCategoryCode ?? "");
              majorDescription.add(category.mainDescription ?? "");
              minorDescription.add(category.subDescription ?? "");
            }

            // convert these list to set
            categoryList = categoryList.toSet().toList();
            mCode = mCode.toSet().toList();
            sCode = sCode.toSet().toList();
            majorDescription = majorDescription.toSet().toList();
            minorDescription = minorDescription.toSet().toList();
          });
          GetBrandServices.getBrandMethod(_sCode, _mCode).then((value) {
            setState(() {
              selectBrand = '';
              brandList.clear();

              selectBrand = value[0];
              // convert brand list to set
              for (var brand in value) {
                brandList.add(brand);
              }
              brandList = value.toSet().toList();
              selectBrand = brandList[0];
            });
          });
          Navigator.of(context).pop();
        }).onError(
          (error, stackTrace) {
            Get.offAll(HomeScreen);
            Get.snackbar(
              "Error",
              error.toString().replaceAll("Exception:", "replace"),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void filterCategoryList() {
    List<String> filteredList = [];
    List<String> filteredSCode = [];
    List<String> filteredMCode = [];
    List<String> filteredMainDescription = [];
    List<String> filteredSubDescription = [];

    for (var category in categoryList) {
      if (category
          .toLowerCase()
          .contains(filterByController.text.toLowerCase())) {
        filteredList.add(category);
        filteredSCode.add(sCode[categoryList.indexOf(category)]);
        filteredMCode.add(mCode[categoryList.indexOf(category)]);
        filteredMainDescription
            .add(majorDescription[categoryList.indexOf(category)]);
        filteredSubDescription
            .add(minorDescription[categoryList.indexOf(category)]);
      }
    }
    setState(() {
      categoryList = filteredList;
      selectCategory = categoryList[0];
      sCode = filteredSCode;
      mCode = filteredMCode;
      majorDescription = filteredMainDescription;
      minorDescription = filteredSubDescription;
    });

    // when search text is cleared, display all the categories
    if (filterByController.text.isEmpty) {
      GetAllCategoriesServices.getAllCategories().then((value) {
        setState(() {
          categoryList.clear();
          sCode.clear();
          mCode.clear();
          majorDescription.clear();
          minorDescription.clear();

          selectCategory = value[0].subDescription.toString();
          for (var category in value) {
            categoryList.add(category.subDescription ?? "");
            mCode.add(category.mainCategoryCode ?? "");
            sCode.add(category.subCategoryCode ?? "");
            majorDescription.add(category.mainDescription ?? "");
            minorDescription.add(category.subDescription ?? "");
          }
        });
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString().replaceAll("Exception:", "replace"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        title: const Text(
          "Asset Capture",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        // back button color to white
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: const Text(
                                      "Category",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: DropdownButtonFormField(
                                      isExpanded: true,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      dropdownColor: Colors.white,
                                      focusColor: Colors.white,
                                      value: selectCategory,
                                      items: categoryList.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) async {
                                        setState(() {
                                          selectCategory = value.toString();
                                          _mCode = mCode[categoryList
                                              .indexOf(value.toString())];
                                          _sCode = sCode[categoryList
                                              .indexOf(value.toString())];
                                          mainDescription = majorDescription[
                                              categoryList
                                                  .indexOf(value.toString())];
                                          subDescription = minorDescription[
                                              categoryList
                                                  .indexOf(value.toString())];

                                          // _tableBrand.add(value.toString());
                                        });
                                        Constant.showLoadingDialog(context);
                                        GetBrandServices.getBrandMethod(
                                                _sCode, _mCode)
                                            .then((value) {
                                          setState(() {
                                            selectBrand = '';
                                            brandList.clear();

                                            selectBrand = value[0];
                                            // convert brand list to set
                                            for (var brand in value) {
                                              brandList.add(brand);
                                            }
                                            brandList = value.toSet().toList();
                                          });
                                          Navigator.pop(context);
                                        }).onError(
                                          (error, stackTrace) {
                                            Navigator.pop(context);
                                            Get.snackbar(
                                              "Not Found",
                                              "No Brand Found in this category",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    // width: MediaQuery.of(context).size.width *
                                    //     0.15,
                                    child: const Text(
                                      "Description",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Text(
                                      widget.poDetail.itemDescription
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: const Text(
                                      "Filter By",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: TextFormField(
                                      controller: filterByController,
                                      decoration: const InputDecoration(
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        filterCategoryList();
                                      },
                                      onEditingComplete: () {
                                        filterCategoryList();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    // width: MediaQuery.of(context).size.width *
                                    //     0.15,
                                    child: const Text(
                                      "Brand/Type",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: DropdownButtonFormField(
                                      dropdownColor: Colors.white,
                                      focusColor: Colors.white,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      value: selectBrand,
                                      isExpanded: true,
                                      items: brandList.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectBrand = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   flex: 1,
                                //   child: IconButton(
                                //     onPressed: () {
                                //       // A dialog box with singhle text field and submit cancel button
                                //       Get.dialog(
                                //         AlertDialog(
                                //           title: const Text(
                                //             "Add Brand",
                                //             style: TextStyle(
                                //               color: Colors.black,
                                //               fontSize: 15,
                                //               fontWeight: FontWeight.bold,
                                //             ),
                                //           ),
                                //           content: TextFormField(
                                //             controller: brandController,
                                //             decoration: const InputDecoration(
                                //               border: OutlineInputBorder(),
                                //             ),
                                //           ),
                                //           actions: [
                                //             TextButton(
                                //               onPressed: () {
                                //                 Navigator.pop(context);
                                //               },
                                //               child: const Text(
                                //                 "Cancel",
                                //                 style: TextStyle(
                                //                   color: Colors.black,
                                //                   fontSize: 15,
                                //                   fontWeight: FontWeight.bold,
                                //                 ),
                                //               ),
                                //             ),
                                //             TextButton(
                                //               onPressed: () async {
                                //                 if (brandController
                                //                     .text.isEmpty) {
                                //                   ScaffoldMessenger.of(
                                //                           context)
                                //                       .showSnackBar(
                                //                     const SnackBar(
                                //                       content: Text(
                                //                           'Please enter brand name'),
                                //                     ),
                                //                   );
                                //                 } else {
                                //                   Constant.showLoadingDialog(
                                //                       context);
                                //                   AddNewBrandServices
                                //                       .addBrand(
                                //                     brandController.text,
                                //                     _mCode,
                                //                     _sCode,
                                //                     context,
                                //                   );
                                //                 }
                                //                 brandList.add(
                                //                     brandController.text);
                                //                 Navigator.pop(context);

                                //                 setState(() {});
                                //               },
                                //               child: const Text(
                                //                 "Submit",
                                //                 style: TextStyle(
                                //                   color: Colors.black,
                                //                   fontSize: 15,
                                //                   fontWeight: FontWeight.bold,
                                //                 ),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       );
                                //     },
                                //     icon: const Icon(
                                //       Icons.add,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    // width: MediaQuery.of(context).size.width *
                                    //     0.15,
                                    child: const Text(
                                      "Model",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: TextFormField(
                                      controller: modelController,
                                      decoration: const InputDecoration(
                                        hintText: "Model",
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            brand.add(selectBrand.toString());
                            model.add(modelController.text);
                            qty.add(qtyController.text);
                            assetClass.add(selectBrand.toString());
                            mCode.add(_mCode);
                            sCode.add(_sCode);
                            majorDescription.add(mainDescription);
                            minorDescription.add(selectCategory.toString());
                            _tableBrand.add(selectCategory.toString());
                          });
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          "Add Item",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constant.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              border: TableBorder.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Constant.primaryColor,
                              ),
                              columnSpacing: 10,
                              dataRowHeight: 30,
                              columns: const [
                                DataColumn(
                                    label: Text(
                                  'Type',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Model',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'QTY',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Asset Class',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'M-Code',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'S-Code',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Major Description',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Minor Description',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ],
                              rows: [
                                for (int i = 0; i < brand.length; i++)
                                  DataRow(
                                    cells: [
                                      DataCell(Text(brand[i])),
                                      DataCell(Text(model[i])),
                                      DataCell(Text(
                                          widget.poDetail.quantity.toString())),
                                      DataCell(Text(_tableBrand[i])),
                                      DataCell(Text(mCode[i])),
                                      DataCell(Text(sCode[i])),
                                      DataCell(Text(majorDescription[i])),
                                      DataCell(Text(
                                          "${_tableBrand[i]} - ${widget.poDetail.itemDescription.toString()}")),
                                      DataCell(
                                        FittedBox(
                                          child: IconButton(
                                            onPressed: () {
                                              Get.dialog(
                                                AlertDialog(
                                                  title: const Text('Delete'),
                                                  content: const Text(
                                                      'Are you sure you want to delete this item?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                        setState(() {
                                                          brand.removeAt(i);
                                                          model.removeAt(i);
                                                          qty.removeAt(i);
                                                          assetClass
                                                              .removeAt(i);
                                                          mCode.removeAt(i);
                                                          sCode.removeAt(i);
                                                          majorDescription
                                                              .removeAt(i);
                                                          minorDescription
                                                              .removeAt(i);
                                                        });
                                                      },
                                                      child: const Text('Yes'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 30,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonWidget(
                            color: Colors.grey,
                            title: "BACK",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height * 0.05,
                            fontSize: 12,
                          ),
                          SizedBox(width: 10),
                          ButtonWidget(
                            color: Constant.primaryColor,
                            title: "Send For Barcode",
                            onPressed: () async {
                              if (brand.isEmpty ||
                                  model.isEmpty ||
                                  qty.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Please add at least one item",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 3),
                                  isDismissible: true,
                                );

                                return;
                              }

                              String userLoginId = "";
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              setState(
                                () {
                                  userLoginId =
                                      prefs.getString("userLoginId") ?? "";
                                },
                              );
                              Constant.showLoadingDialog(context);

                              for (int i = 0; i < model.length; i++) {
                                int leng = int.parse(qty[i]);

                                for (int j = 0; j < leng; j++) {
                                  SendForBarCodeServices.sendForBarCode(
                                    int.parse(
                                        widget.poDetail.quantity.toString()),
                                    mCode[i],
                                    // "widget.businessUnit",
                                    "",
                                    majorDescription[i],
                                    sCode[i],
                                    // _tableBrand[i],
                                    "${_tableBrand[i]} - ${widget.poDetail.itemDescription.toString()}",
                                    "${_tableBrand[i]} ${brand[i]} ${model[i]}",
                                    // "widget.country",
                                    "",
                                    // "widget.region",
                                    "",
                                    // "widget.city",
                                    "",
                                    // "widget.departmentCode",
                                    "",
                                    // "widget.department",
                                    "",
                                    // "widget.buildingNumber",
                                    "",
                                    // "widget.floorNumber",
                                    "",
                                    model[i],
                                    brand[i],
                                    // "widget.buildingName",
                                    "",
                                    // "widget.buildingAddress",
                                    "",
                                    userLoginId.toString().replaceAll("\"", ""),
                                  ).then((value) {
                                    Navigator.of(context).pop();
                                    Get.snackbar(
                                      "Success",
                                      "Barcode send successfully",
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 3),
                                      isDismissible: true,
                                    );

                                    Get.offAll(const HomeScreen());
                                  }).onError((error, stackTrace) {
                                    Navigator.of(context).pop();
                                    Get.snackbar(
                                      "Error",
                                      "Failed to send barcode",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 3),
                                      isDismissible: true,
                                    );
                                  });
                                }
                              }
                            },
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height * 0.05,
                            fontSize: 12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    filterByController.dispose();
    modelController.dispose();
    qtyController.clear();
    qtyController.dispose();

    brandList.clear();
    selectBrand = "Select Brand";
    brandList.insert(0, "Select Brand");

    categoryList.clear();
    selectCategory = "Select Category";
    categoryList.insert(0, "Select Category");

    brand.clear();
    model.clear();
    qty.clear();
    assetClass.clear();
    mCode.clear();
    sCode.clear();
    majorDescription.clear();
    minorDescription.clear();

    _tableBrand.clear();
  }
}
