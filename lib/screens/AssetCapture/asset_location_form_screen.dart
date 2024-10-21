// ignore_for_file: non_constant_identifier_names

import 'package:fats_mobile_demo/Services/GetAllCities/GetAllCitiesService.dart';
import 'package:fats_mobile_demo/screens/AssetCapture/send_barcode_screen.dart';
import 'package:fats_mobile_demo/Services/GetArea/getAreaServices.dart';
import 'package:fats_mobile_demo/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Services/GetDepartment/getDepartment.dart';
import '../../widgets/text_form_field_widget.dart';
import '../../Services/Login/LoginServices.dart';
import '../../widgets/button_widget.dart';

class AssetLocationFormScreen extends StatefulWidget {
  const AssetLocationFormScreen({super.key});

  @override
  State<AssetLocationFormScreen> createState() =>
      _AssetLocationFormScreenState();
}

class _AssetLocationFormScreenState extends State<AssetLocationFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String regionCode = "";
  String area = "";

  String selectFloorNo = "Select Floor No";
  List<String> floorNoList = [
    "Select Floor No",
  ];

  String selectCountry = "Select Country";
  List<String> countryList = [
    "Select Country",
  ];

  String selectCity = "Select City";
  List<String> cityList = [
    "Select City",
  ];

  String departmentName = "Select Department";
  List<String> departmentList = [
    "Select Department",
  ];

  String businessUnit = "BU";
  List<String> businessUnitList = [
    "Select Business Unit",
  ];

  String departmentCode = "Select Department Code";
  List<String> departmentCodeList = [
    "Select Department Code",
  ];

  List countryIdList = [];
  String countryId = "";

  TextEditingController areaController = TextEditingController();
  TextEditingController departmentCodeController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController buildingAddressController = TextEditingController();
  TextEditingController buildingNoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      Constant.showLoadingDialog(context);

      var value = await LoginServices.countriesList();
      setState(() {
        for (var i = 0; i < value.length; i++) {
          countryList.add(value[i].countryName!);
          countryIdList.add(value[i].tblCountryID.toString());
        }
        countryId = countryIdList[0];
        Set<String> countrySet = countryList.toSet();
        countryList = countrySet.toList();
      });

      var city = await GetAllCitiesService.getCityById(countryId);

      setState(() {
        for (var i = 0; i < city.length; i++) {
          cityList.add(city[i].cityName!);
        }
        Set<String> citySet = cityList.toSet();
        cityList = citySet.toList();
        selectCity = cityList[0];
      });
      Navigator.of(context).pop();

      var department = await GetAllDepartmentsService.getAllDepartments();

      setState(() {
        departmentList = [];
        for (var i = 0; i < department.length; i++) {
          departmentList.add(department[i].daoName!);
        }
        Set<String> regionSet = departmentList.toSet();
        departmentList = regionSet.toList();
        departmentName = departmentList[0];

        floorNoList.clear();

        for (var i = 0; i < department.length; i++) {
          floorNoList.add(department[i].bUSINESSGROUP!);
        }

        Set<String> floorNoSet = floorNoList.toSet();
        floorNoList = floorNoSet.toList();
        selectFloorNo = floorNoList[0];

        businessUnitList.clear();
        for (var i = 0; i < department.length; i++) {
          businessUnitList.add(department[i].businessUnit!);
        }

        Set<String> businessUnitSet = businessUnitList.toSet();
        businessUnitList = businessUnitSet.toList();
        businessUnit = businessUnitList[0];

        departmentCodeList.clear();

        for (var i = 0; i < department.length; i++) {
          departmentCodeList.add(department[i].dAONumber!);
        }

        Set<String> departmentCodeSet = departmentCodeList.toSet();
        departmentCodeList = departmentCodeSet.toList();

        businessNameController.text = businessUnitList[0];
        departmentCodeController.text = departmentCodeList[0];
      });
      var area = await GetAreaServices.getArea(regionCode);
      setState(() {
        print(area);
        areaController.text = area;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    areaController.dispose();
    departmentCodeController.dispose();
    businessNameController.dispose();
    buildingNameController.dispose();
    buildingAddressController.dispose();
    buildingNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Asset Location Form",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Constant.primaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Country ...............................................
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "COUNTRY",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        value: selectCountry,
                        isExpanded: true,
                        items: countryList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectCountry = value.toString();
                          countryId =
                              countryIdList[countryList.indexOf(value!) - 1];
                          print(countryId);
                          GetAllCitiesService.getCityById(countryId)
                              .then((value) {
                            setState(() {
                              cityList = [];
                              for (var i = 0; i < value.length; i++) {
                                cityList.add(value[i].cityName!);
                              }
                              Set<String> citySet = cityList.toSet();
                              cityList = citySet.toList();
                              selectCity = cityList[0];
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Text(
                        "CITY",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        value: selectCity,
                        isExpanded: true,
                        items: cityList.map((value) {
                          // index = cityList.indexOf(value);
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectCity = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: regionCode == "" ? false : true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const Text(
                          "Area",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        width: MediaQuery.of(context).size.width * 1,
                        readOnly: true,
                        controller: areaController,
                        height: 50,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Department ...............................................
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Text(
                        "Department",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        value: departmentName,
                        isExpanded: true,
                        items: departmentList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            departmentName = value.toString();

                            var index =
                                departmentList.indexOf(value.toString());

                            print("Index: $index");

                            businessNameController.text =
                                businessUnitList[index];

                            departmentCodeController.text =
                                departmentCodeList[index];
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Department Code",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      readOnly: true,
                      controller: departmentCodeController,
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Business Name",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      readOnly: true,
                      controller: businessNameController,
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Building Name",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      controller: buildingNameController,
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Building Address",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      controller: buildingAddressController,
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Building No",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      controller: buildingNoController,
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Floor No",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        value: selectFloorNo,
                        isExpanded: true,
                        items: floorNoList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectFloorNo = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        fontSize: 15,
                        color: Colors.grey,
                        title: "BACK",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ButtonWidget(
                        fontSize: 15,
                        color: Constant.primaryColor,
                        title: "NEXT",
                        onPressed: () {
                          if (selectCountry.isEmpty ||
                              selectCity.isEmpty ||
                              departmentCodeController.text.isEmpty ||
                              businessNameController.text.isEmpty ||
                              buildingNameController.text.isEmpty ||
                              buildingAddressController.text.isEmpty ||
                              buildingNoController.text.isEmpty ||
                              floorNoList.isEmpty ||
                              businessUnit.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Please Fill All the above fields"),
                              ),
                            );
                          } else {
                            Get.to(
                              () => SendBarCodeScreen(
                                country: selectCountry.toString(),
                                city: selectCity.toString(),
                                department: departmentName.toString(),
                                departmentCode:
                                    departmentCodeController.text.trim(),
                                businessName:
                                    businessNameController.text.trim(),
                                buildingName:
                                    buildingNameController.text.trim(),
                                buildingAddress:
                                    buildingAddressController.text.trim(),
                                buildingNumber:
                                    buildingNoController.text.trim(),
                                floorNumber: selectFloorNo.toString(),
                                region: areaController.text.trim(),
                                businessUnit: businessUnit.toString(),
                              ),
                            );
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
