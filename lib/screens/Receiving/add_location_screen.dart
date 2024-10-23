// ignore_for_file: non_constant_identifier_names

import 'package:fats_mobile_demo/Services/GetAllCities/GetAllCitiesService.dart';
import 'package:fats_mobile_demo/cubit/barcode/barcode_cubit.dart';
import 'package:fats_mobile_demo/Services/GetArea/getAreaServices.dart';
import 'package:fats_mobile_demo/constants.dart';
import 'package:flutter/material.dart';

import '../../Services/GetDepartment/getDepartment.dart';
import '../../widgets/text_form_field_widget.dart';
import '../../Services/Login/LoginServices.dart';
import '../../widgets/button_widget.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      Constant.showLoadingDialog(context);

      var value = await LoginServices.countriesList();
      setState(() {
        for (var i = 0; i < value.length; i++) {
          BarcodeCubit.get(context).countryList.add(value[i].countryName!);
          BarcodeCubit.get(context)
              .countryIdList
              .add(value[i].tblCountryID.toString());
        }
        BarcodeCubit.get(context).countryId =
            BarcodeCubit.get(context).countryIdList[0];
        Set<String> countrySet = BarcodeCubit.get(context).countryList.toSet();
        BarcodeCubit.get(context).countryList = countrySet.toList();
      });

      var city = await GetAllCitiesService.getCityById(
          BarcodeCubit.get(context).countryId);

      setState(() {
        for (var i = 0; i < city.length; i++) {
          BarcodeCubit.get(context).cityList.add(city[i].cityName!);
        }
        Set<String> citySet = BarcodeCubit.get(context).cityList.toSet();
        BarcodeCubit.get(context).cityList = citySet.toList();
        BarcodeCubit.get(context).selectCity =
            BarcodeCubit.get(context).cityList[0];
      });
      Navigator.of(context).pop();

      var department = await GetAllDepartmentsService.getAllDepartments();

      setState(() {
        BarcodeCubit.get(context).departmentList = [];
        for (var i = 0; i < department.length; i++) {
          BarcodeCubit.get(context).departmentList.add(department[i].daoName!);
        }
        Set<String> regionSet =
            BarcodeCubit.get(context).departmentList.toSet();
        BarcodeCubit.get(context).departmentList = regionSet.toList();
        BarcodeCubit.get(context).departmentName =
            BarcodeCubit.get(context).departmentList[0];

        BarcodeCubit.get(context).floorNoList.clear();

        for (var i = 0; i < department.length; i++) {
          BarcodeCubit.get(context)
              .floorNoList
              .add(department[i].bUSINESSGROUP!);
        }

        Set<String> floorNoSet = BarcodeCubit.get(context).floorNoList.toSet();
        BarcodeCubit.get(context).floorNoList = floorNoSet.toList();
        BarcodeCubit.get(context).selectFloorNo =
            BarcodeCubit.get(context).floorNoList[0];

        BarcodeCubit.get(context).businessUnitList.clear();
        for (var i = 0; i < department.length; i++) {
          BarcodeCubit.get(context)
              .businessUnitList
              .add(department[i].businessUnit!);
        }

        Set<String> businessUnitSet =
            BarcodeCubit.get(context).businessUnitList.toSet();
        BarcodeCubit.get(context).businessUnitList = businessUnitSet.toList();
        BarcodeCubit.get(context).businessUnit =
            BarcodeCubit.get(context).businessUnitList[0];

        BarcodeCubit.get(context).departmentCodeList.clear();

        for (var i = 0; i < department.length; i++) {
          BarcodeCubit.get(context)
              .departmentCodeList
              .add(department[i].dAONumber!);
        }

        Set<String> departmentCodeSet =
            BarcodeCubit.get(context).departmentCodeList.toSet();
        BarcodeCubit.get(context).departmentCodeList =
            departmentCodeSet.toList();

        BarcodeCubit.get(context).businessNameController.text =
            BarcodeCubit.get(context).businessUnitList[0];
        BarcodeCubit.get(context).departmentCodeController.text =
            BarcodeCubit.get(context).departmentCodeList[0];
      });
      var area =
          await GetAreaServices.getArea(BarcodeCubit.get(context).regionCode);
      setState(() {
        print(area);
        BarcodeCubit.get(context).areaController.text = area;
      });
    });
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
                        value: BarcodeCubit.get(context).selectCountry,
                        isExpanded: true,
                        dropdownColor: Colors.white, // Add this line
                        items:
                            BarcodeCubit.get(context).countryList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          BarcodeCubit.get(context).selectCountry =
                              value.toString();
                          BarcodeCubit.get(context).countryId =
                              BarcodeCubit.get(context).countryIdList[
                                  BarcodeCubit.get(context)
                                          .countryList
                                          .indexOf(value!) -
                                      1];
                          print(BarcodeCubit.get(context).countryId);
                          GetAllCitiesService.getCityById(
                                  BarcodeCubit.get(context).countryId)
                              .then((value) {
                            setState(() {
                              BarcodeCubit.get(context).cityList = [];
                              for (var i = 0; i < value.length; i++) {
                                BarcodeCubit.get(context)
                                    .cityList
                                    .add(value[i].cityName!);
                              }
                              Set<String> citySet =
                                  BarcodeCubit.get(context).cityList.toSet();
                              BarcodeCubit.get(context).cityList =
                                  citySet.toList();
                              BarcodeCubit.get(context).selectCity =
                                  BarcodeCubit.get(context).cityList[0];
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
                        value: BarcodeCubit.get(context).selectCity,
                        isExpanded: true,
                        dropdownColor: Colors.white, // Add this line
                        items: BarcodeCubit.get(context).cityList.map((value) {
                          // index = cityList.indexOf(value);
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            BarcodeCubit.get(context).selectCity =
                                value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible:
                      BarcodeCubit.get(context).regionCode == "" ? false : true,
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
                        controller: BarcodeCubit.get(context).areaController,
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
                        value: BarcodeCubit.get(context).departmentName,
                        isExpanded: true,
                        dropdownColor: Colors.white, // Add this line
                        items: BarcodeCubit.get(context)
                            .departmentList
                            .map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            BarcodeCubit.get(context).departmentName =
                                value.toString();

                            var index = BarcodeCubit.get(context)
                                .departmentList
                                .indexOf(value.toString());

                            print("Index: $index");

                            BarcodeCubit.get(context)
                                    .businessNameController
                                    .text =
                                BarcodeCubit.get(context)
                                    .businessUnitList[index];

                            BarcodeCubit.get(context)
                                    .departmentCodeController
                                    .text =
                                BarcodeCubit.get(context)
                                    .departmentCodeList[index];
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
                      controller:
                          BarcodeCubit.get(context).departmentCodeController,
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
                      controller:
                          BarcodeCubit.get(context).businessNameController,
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
                      controller:
                          BarcodeCubit.get(context).buildingNameController,
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
                      controller:
                          BarcodeCubit.get(context).buildingAddressController,
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
                      controller:
                          BarcodeCubit.get(context).buildingNoController,
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
                        value: BarcodeCubit.get(context).selectFloorNo,
                        isExpanded: true,
                        dropdownColor: Colors.white, // Add this line
                        items:
                            BarcodeCubit.get(context).floorNoList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            BarcodeCubit.get(context).selectFloorNo =
                                value.toString();
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
                          BarcodeCubit.get(context).submiitBarcode(context);
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
