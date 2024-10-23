import 'package:fats_mobile_demo/cubit/barcode/barcode_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeCubit extends Cubit<BarcodeState> {
  BarcodeCubit() : super(BarcodeInitial());

  static BarcodeCubit get(context) => BlocProvider.of(context);

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

  // dispose controller
  void dispose() {
    areaController.dispose();
    departmentCodeController.dispose();
    businessNameController.dispose();
  }

  // clear all the fields
  void clearAllFields() {
    areaController.clear();
    departmentCodeController.clear();
    businessNameController.clear();
  }

  // submit the barcode
  void submitBarcode(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future onSubmit(BuildContext context) async {
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
          content: Text("Please Fill All the above fields"),
        ),
      );
    } else {
      submitBarcode(context);
    }
  }

  Future<void> submiitBarcode(BuildContext context) async {
    emit(BarcodeLoading());
    try {
      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          await onSubmit(context);
          emit(BarcodeSuccess(message: "Barcode Submitted Successfully"));
        },
      );
    } catch (e) {
      emit(BarcodeError(error: e.toString()));
    }
  }
}
