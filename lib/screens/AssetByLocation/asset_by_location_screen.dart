import 'package:fats_mobile_demo/Services/AssetByLocation/GetAllAssetByLocationServices.dart';
import 'package:fats_mobile_demo/models/AssetByLocationModel.dart';
import 'package:fats_mobile_demo/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../widgets/text_form_field_widget.dart';
import 'LocationDetailsScreen.dart';

class AssetByLocationScreen extends StatefulWidget {
  const AssetByLocationScreen({super.key});

  @override
  State<AssetByLocationScreen> createState() => _AssetByLocationScreenState();
}

class _AssetByLocationScreenState extends State<AssetByLocationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _locationController.dispose();
  }

  List<AssetByLocationModel> getAllAssetByLocationList = [];
  List<bool> isMarked = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        title: Text(
          'Asset By Location',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // back button color white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 10,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          child: Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: _locationController,
                                height: 60,
                                width: MediaQuery.of(context).size.width * 0.9,
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();

                                  Constant.showLoadingDialog(context);

                                  GetAllAssetByLocationServices
                                          .getAllEmployeeList(
                                              _locationController.text)
                                      .then((value) {
                                    setState(() {
                                      getAllAssetByLocationList = value;
                                      isMarked = List<bool>.filled(
                                          getAllAssetByLocationList.length,
                                          false);
                                    });
                                    Navigator.pop(context);
                                  }).onError((error, stackTrace) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(error
                                            .toString()
                                            .replaceAll(
                                                "Exception:", "replace")),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Constant.showLoadingDialog(context);
                                GetAllAssetByLocationServices
                                        .getAllEmployeeList(
                                            _locationController.text)
                                    .then((value) {
                                  setState(() {
                                    getAllAssetByLocationList = value;
                                    isMarked = List<bool>.filled(
                                        getAllAssetByLocationList.length,
                                        false);
                                  });
                                  Navigator.pop(context);
                                }).onError((error, stackTrace) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error.toString()),
                                    ),
                                  );
                                });
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Constant.primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(Icons.search),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Asset Location Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 3,
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          dataRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.grey.withOpacity(0.2)),
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Constant.primaryColor),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          border: TableBorder.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          columns: const [
                            DataColumn(
                                label: Text(
                              'Select',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text(
                              'Asset Description',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text('Serial No.',
                                    style: TextStyle(color: Colors.white))),
                            DataColumn(
                                label: Text('Tags No.',
                                    style: TextStyle(color: Colors.white))),
                            DataColumn(
                                label: Text(
                              'Minor Description',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                          ],
                          rows: getAllAssetByLocationList
                              .map(
                                (e) => DataRow(
                                  cells: [
                                    DataCell(
                                      Checkbox(
                                        value: isMarked[
                                            getAllAssetByLocationList
                                                .indexOf(e)],
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              for (int i = 0;
                                                  i < isMarked.length;
                                                  i++) {
                                                isMarked[i] = false;
                                              }
                                              isMarked[getAllAssetByLocationList
                                                  .indexOf(e)] = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.aSSETdESCRIPTION ?? '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isMarked[
                                                  getAllAssetByLocationList
                                                      .indexOf(e)]
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.sERIALnUMBER ?? '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isMarked[
                                                  getAllAssetByLocationList
                                                      .indexOf(e)]
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.tagNumber ?? '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isMarked[
                                                  getAllAssetByLocationList
                                                      .indexOf(e)]
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.minorCategoryDescription ?? '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isMarked[
                                                  getAllAssetByLocationList
                                                      .indexOf(e)]
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  !isMarked.contains(true)
                      ? Container()
                      : ButtonWidget(
                          title: "Click here for more information",
                          onPressed: () {
                            Get.to(LocationDetailsScreen(
                              locationTag: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .locationTag ??
                                  '',
                              tagNumner: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .tagNumber ??
                                  '',
                              assetLocationDetails: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .fullLocationDetails ??
                                  '',
                              serialNo: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .sERIALnUMBER ??
                                  '',
                              employeeId: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .eMPLOYEEID ??
                                  '',
                              phoneNo: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .phoneExtNo ??
                                  '',
                              otherTag: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .aTMNumber ??
                                  '',
                              notes: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .deliveryNoteNo ??
                                  '',
                              assetCondition: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .aSSETcONDITION ??
                                  '',
                              bought: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .bought ??
                                  '',
                              images: getAllAssetByLocationList[
                                          isMarked.indexOf(true)]
                                      .images ??
                                  '',
                            ));
                          },
                          color: Colors.grey,
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.9,
                          fontSize: 15,
                        ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Text(
                          "Total Assets",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              getAllAssetByLocationList.length.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    title: "Back",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Constant.primaryColor,
                    height: 40,
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
