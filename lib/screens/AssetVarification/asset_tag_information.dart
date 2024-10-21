import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Services/AssetVarification/AsseetConditionServices.dart';
import '../../Services/AssetVarification/BoughtServices.dart';
import '../../Services/AssetVarification/EmployeeNameIdServices.dart';
import '../../Services/AssetVarification/SaveTag.dart';
import '../../Services/AssetVarification/TagNumberServices.dart';
import '../../constants.dart';
import '../../widgets/text_form_field_widget.dart';

class AssetTagInformation extends StatefulWidget {
  const AssetTagInformation({super.key});

  @override
  State<AssetTagInformation> createState() => _AssetTagInformationState();
}

class _AssetTagInformationState extends State<AssetTagInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _locationTagController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _assetLocationDetailsController =
      TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _phoneExtensionController =
      TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _otherTagController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? selectEmployeeName;
  var employeeNameList = [];

  String? selectAssetCondition;
  var assetConditionList = [];

  String? selectBought;
  var boughtList = [];

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  var employeeIdList = [];

  @override
  void initState() {
    super.initState();
    EmployeeNameIdServices.nameIDMethod().then((employees) {
      setState(() {
        selectEmployeeName = employees[0].empName.toString();
        _employeeIdController.text = employees[0].empID.toString();

        for (var employee in employees) {
          employeeNameList.add(employee.empName.toString());
          employeeIdList.add(employee.empID.toString());
        }
      });
    });

    AssetConditionServices.assetCondition().then((assetCondition) {
      setState(() {
        selectAssetCondition =
            assetCondition[0].tblConditionDescription.toString();
        for (var asset in assetCondition) {
          assetConditionList.add(asset.tblConditionDescription.toString());
        }
      });
    });

    BoughtServices.assetCondition().then((value) {
      setState(() {
        selectBought = value[0].tblConditionDescriptionBought.toString();
        for (var bought in value) {
          boughtList.add(bought.tblConditionDescriptionBought.toString());
        }

        isLoading = false;
      });
    });
  }

  bool isLoading = true;

  int tblAssetMasterEncodeAssetCaptureID = 0;
  String majorCategory = "";
  String majorCategoryDescription = "";
  String minorCategory = "";
  String minorCategoryDescription = "";
  String tagNumber = "";
  String serialNumber = '';
  String assetDescription = "";
  String assetType = '';
  String assetCondition = '';
  String country = "";
  String region = "";
  String cityName = "";
  String dao = "";
  String daoName = '';
  String businessUnit = "";
  String buildingNo = "";
  String floorNo = "";
  String employeeID = '';
  String ponNumber = '';
  String poDate = '';
  String deliveryNoteNo = '';
  String supplier = '';
  String invoiceNo = '';
  String invoiceDate = '';
  String modelOfAsset = "";
  String manufacturer = "";
  String ownership = '';
  String bought = '';
  String terminalID = '';
  String atmNumber = '';
  String locationTag = '';
  String buildingName = "";
  String buildingAddress = "";
  String userLoginID = "";
  int mainSubSeriesNo = 0;
  String assetDateCaptured = '';
  String assetTimeCaptured = '';
  String assetDateScanned = '';
  String assetTimeScanned = '';
  int qty = 0;
  String phoneExtNo = '';
  String fullLocationDetails = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading icon color white
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Constant.primaryColor,
        title: const Text(
          'Asset Tag Information',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              color: Constant.primaryColor,
              backgroundColor: Colors.white,
              strokeWidth: 10,
              strokeCap: StrokeCap.round,
            ))
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Location Tag",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormFieldWidget(
                              controller: _locationTagController,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Tag*",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormFieldWidget(
                                      controller: _tagController,
                                      height: 50,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Constant.primaryColor,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () async {
                                          TagNumberServices.tagNo(
                                                  _tagController.text)
                                              .then((value) {
                                            var daoName =
                                                value.recordset![0].daoName ??
                                                    "";

                                            var businessUnit = value
                                                    .recordset![0]
                                                    .businessUnit ??
                                                "";
                                            var buildingAddress = value
                                                    .recordset![0]
                                                    .buildingAddress ??
                                                "";
                                            var buildingNo = value
                                                    .recordset![0].bUILDINGNO ??
                                                "";
                                            var floorNo =
                                                value.recordset![0].fLOORNO ??
                                                    "";

                                            setState(() {
                                              _assetLocationDetailsController
                                                      .text =
                                                  "$daoName - $businessUnit\n$buildingAddress\n$buildingNo - $floorNo";

                                              tblAssetMasterEncodeAssetCaptureID =
                                                  value.recordset![0]
                                                          .tblAssetMasterEncodeAssetCaptureID ??
                                                      0;
                                              majorCategory = value
                                                      .recordset![0]
                                                      .majorCategory ??
                                                  "";
                                              majorCategoryDescription = value
                                                      .recordset![0]
                                                      .majorCategoryDescription ??
                                                  "";
                                              minorCategory = value
                                                      .recordset![0]
                                                      .minorCategoryDescription ??
                                                  "";
                                              minorCategoryDescription = value
                                                      .recordset![0]
                                                      .minorCategoryDescription ??
                                                  "";
                                              tagNumber = value.recordset![0]
                                                      .tagNumber ??
                                                  "";
                                              serialNumber = value.recordset![0]
                                                      .sERIALnUMBER ??
                                                  "";
                                              assetDescription = value
                                                      .recordset![0]
                                                      .aSSETdESCRIPTION ??
                                                  "";
                                              assetType = value.recordset![0]
                                                      .assettYPE ??
                                                  "";
                                              assetCondition = value
                                                      .recordset![0]
                                                      .aSSETcONDITION ??
                                                  "";
                                              country =
                                                  value.recordset![0].cOUNTRY ??
                                                      "";
                                              region =
                                                  value.recordset![0].rEGION ??
                                                      "";
                                              cityName = value
                                                      .recordset![0].cityName ??
                                                  "";
                                              dao =
                                                  value.recordset![0].dao ?? "";
                                              daoName =
                                                  value.recordset![0].daoName ??
                                                      "";
                                              businessUnit = value.recordset![0]
                                                      .businessUnit ??
                                                  "";
                                              buildingNo = value.recordset![0]
                                                      .bUILDINGNO ??
                                                  "";
                                              floorNo =
                                                  value.recordset![0].fLOORNO ??
                                                      "";
                                              employeeID = value.recordset![0]
                                                      .eMPLOYEEID ??
                                                  "";
                                              ponNumber = value
                                                      .recordset![0].ponUmber ??
                                                  "";
                                              poDate =
                                                  value.recordset![0].podate ??
                                                      "";
                                              deliveryNoteNo = value
                                                      .recordset![0]
                                                      .deliveryNoteNo ??
                                                  "";
                                              supplier = value
                                                      .recordset![0].supplier ??
                                                  "";
                                              invoiceNo = value.recordset![0]
                                                      .invoiceNo ??
                                                  "";
                                              invoiceDate = value.recordset![0]
                                                      .invoiceDate ??
                                                  "";
                                              modelOfAsset = value.recordset![0]
                                                      .modelofAsset ??
                                                  "";
                                              manufacturer = value.recordset![0]
                                                      .manufacturer ??
                                                  "";
                                              ownership = value.recordset![0]
                                                      .ownership ??
                                                  "";
                                              bought =
                                                  value.recordset![0].bought ??
                                                      "";
                                              terminalID = value.recordset![0]
                                                      .terminalID ??
                                                  "";
                                              atmNumber = value.recordset![0]
                                                      .aTMNumber ??
                                                  "";
                                              locationTag = value.recordset![0]
                                                      .locationTag ??
                                                  "";
                                              assetDateCaptured = value
                                                      .recordset![0]
                                                      .assetdatecaptured ??
                                                  "";
                                              assetTimeCaptured = value
                                                      .recordset![0]
                                                      .assetTimeCaptured ??
                                                  "";
                                              assetDateScanned = value
                                                      .recordset![0]
                                                      .assetdatescanned ??
                                                  "";
                                              assetTimeScanned = value
                                                      .recordset![0]
                                                      .assettimeScanned ??
                                                  "";
                                              qty = value.recordset![0].qTY!;
                                              phoneExtNo = value.recordset?[0]
                                                      .phoneExtNo ??
                                                  "";
                                              userLoginID = value.recordset?[0]
                                                      .userLoginID ??
                                                  "";
                                            });
                                            // unFocused the textfield
                                            FocusScope.of(context).unfocus();
                                            print(
                                                "$daoName - $businessUnit\n$buildingAddress\n$buildingNo - $floorNo");
                                          }).onError((error, stackTrace) {
                                            FocusScope.of(context).unfocus();
                                            _assetLocationDetailsController
                                                .text = "";
                                            _assetLocationDetailsController
                                                .text = "No Data Found";
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "No Data Found",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Colors.redAccent,
                                              ),
                                            );
                                          });
                                        },
                                        child: const Text('Search'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Asset Location Details",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                controller: _assetLocationDetailsController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Serial No",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormFieldWidget(
                              controller: _serialNoController,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Employee Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Employee Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonFormField(
                                value: selectEmployeeName,
                                isExpanded: true,
                                items: employeeNameList.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectEmployeeName = value.toString();
                                      _employeeIdController.text =
                                          employeeIdList[
                                              employeeNameList.indexOf(value)];
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        // Employee Id
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Employee Id",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormFieldWidget(
                              readOnly: true,
                              controller: _employeeIdController,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        // phone extension
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Phone Extension",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormFieldWidget(
                              controller: _phoneExtensionController,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // other tag
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Other Tag",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            TextFormFieldWidget(
                              controller: _otherTagController,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // notes
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Notes",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                controller: _notesController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                try {
                                  final imgpicker = ImagePicker();

                                  var pickedfile = await imgpicker.pickImage(
                                      source: ImageSource.camera);
                                  //you can use ImageCourse.camera for Camera capture

                                  if (pickedfile != null) {
                                    if (imagefiles != null) {
                                      imagefiles!.add(pickedfile);
                                    } else {
                                      imagefiles = [pickedfile];
                                    }
                                    setState(() {});
                                  } else {
                                    print("No image is selected.");
                                  }
                                } catch (e) {
                                  print("error while picking file.");
                                }
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                try {
                                  final imgpicker = ImagePicker();

                                  var pickedfiles =
                                      await imgpicker.pickMultiImage();
                                  //you can use ImageCourse.camera for Camera capture

                                  if (pickedfiles.isNotEmpty &&
                                      pickedfiles.length <= 4) {
                                    if (imagefiles != null) {
                                      for (var i = 0;
                                          i < imagefiles!.length;
                                          i++) {
                                        pickedfiles.add(imagefiles![i]);
                                      }
                                    }
                                    imagefiles = pickedfiles;

                                    setState(() {});
                                  } else {
                                    print("No image is selected.");
                                  }
                                } catch (e) {
                                  print("error while picking file.");
                                }
                              },
                              icon: const Icon(
                                Icons.add_photo_alternate,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Add upto 4 images",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),

                        const SizedBox(height: 20),
                        imagefiles != null
                            ? Wrap(
                                children: imagefiles!.map((imageone) {
                                  return Stack(
                                    children: [
                                      Card(
                                        shadowColor: Constant.primaryColor,
                                        elevation: 10,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: SizedBox(
                                          height: 70,
                                          width: 60,
                                          child: Image.file(
                                            File(imageone.path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                          onPressed: () {
                                            imagefiles!.remove(imageone);
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.red.withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        // asset condition
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Asset Condition",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonFormField(
                                value: selectAssetCondition,
                                isExpanded: true,
                                items: assetConditionList.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectAssetCondition = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        // bought
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Bought",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonFormField(
                                value: selectBought,
                                isExpanded: true,
                                items: boughtList.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectBought = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Back'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constant.primaryColor,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () async {
                                    Constant.showLoadingDialog(context);
                                    if (_tagController.text.trim().isEmpty ||
                                        _serialNoController.text
                                            .trim()
                                            .isEmpty ||
                                        _employeeIdController.text
                                            .trim()
                                            .isEmpty ||
                                        _notesController.text.trim().isEmpty ||
                                        _otherTagController.text
                                            .trim()
                                            .isEmpty ||
                                        _locationTagController.text
                                            .trim()
                                            .isEmpty) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Please fill all the fields"),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      SaveTagServices.saveTag(
                                        tblAssetMasterEncodeAssetCaptureID,
                                        majorCategory,
                                        majorCategoryDescription,
                                        minorCategory,
                                        minorCategoryDescription,
                                        _tagController.text.trim(),
                                        _serialNoController.text.trim(),
                                        assetDescription,
                                        assetType,
                                        selectAssetCondition.toString(),
                                        country,
                                        region,
                                        cityName,
                                        dao,
                                        daoName,
                                        businessUnit,
                                        buildingNo,
                                        floorNo,
                                        _employeeIdController.text.trim(),
                                        ponNumber,
                                        poDate,
                                        _notesController.text.trim(),
                                        supplier,
                                        invoiceNo,
                                        invoiceDate,
                                        modelOfAsset,
                                        manufacturer,
                                        ownership,
                                        selectBought.toString(),
                                        terminalID,
                                        _otherTagController.text.trim(),
                                        _locationTagController.text.trim(),
                                        buildingName,
                                        buildingAddress,
                                        mainSubSeriesNo,
                                        assetDateCaptured,
                                        assetTimeCaptured,
                                        assetDateScanned,
                                        assetTimeScanned,
                                        qty,
                                        _phoneExtensionController.text.trim(),
                                        _assetLocationDetailsController.text
                                            .trim(),
                                        imagefiles!,
                                      ).then((value) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Data Saved Successfully",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }).onError((error, stackTrace) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Error while saving data",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      });
                                    }
                                  },
                                  child: const Text('Save'),
                                ),
                              ),
                            ],
                          ),
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
    _locationTagController.dispose();
    _tagController.dispose();
    _assetLocationDetailsController.dispose();
    _serialNoController.dispose();
    _phoneExtensionController.dispose();
    _employeeIdController.dispose();
    _otherTagController.dispose();
    _notesController.dispose();

    employeeNameList.clear();

    assetConditionList.clear();
    selectAssetCondition = "Select Asset Condition";
    assetConditionList.insert(0, "Select Asset Condition");

    boughtList.clear();
    selectBought = "Select Asset Bought";
    boughtList.insert(0, "Select Asset Bought");

    imagefiles?.clear();
  }
}
