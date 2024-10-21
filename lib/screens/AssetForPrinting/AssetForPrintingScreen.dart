import 'package:fats_mobile_demo/Services/AssetForPrinting/AssetForPrintingServices.dart';
import 'package:fats_mobile_demo/Services/AssetVarification/DeleteTag.dart';
import 'package:fats_mobile_demo/screens/AssetForPrinting/BarcodeLabelScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../models/AssetForPrintingModel.dart';

class AssetForPrintingScreen extends StatefulWidget {
  const AssetForPrintingScreen({super.key});

  @override
  State<AssetForPrintingScreen> createState() => _AssetForPrintingScreenState();
}

class _AssetForPrintingScreenState extends State<AssetForPrintingScreen> {
  List<AssetForPrintingModel> assetGenerateModel = [];
  List<bool> isMarked = [];
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        AssetForPrintingServices.assetForPrint().then(
          (response) {
            assetGenerateModel = response;
            for (int i = 0; i < assetGenerateModel.length; i++) {
              isMarked.add(false);
            }
            setState(() {
              isLoading = false;
            });
          },
        ).onError(
          (error, stackTrace) {
            Navigator.pop(context);
            print("Error is: $error");
            setState(() {
              isLoading = false;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Printing Assets'),
        backgroundColor: Constant.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Constant.primaryColor,
                strokeWidth: 10,
                strokeCap: StrokeCap.round,
              ),
            )
          : assetGenerateModel.isEmpty
              ? Center(
                  child: Image.network(Constant.placeHolderImage),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          PaginatedDataTable(
                            header: const Text(
                              'Assets',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            rowsPerPage: rowsPerPage,
                            headingRowColor: MaterialStateProperty.all(
                                Constant.primaryColor),
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                rowsPerPage = value ??
                                    PaginatedDataTable.defaultRowsPerPage;
                              });
                            },
                            columns: [
                              dataColumnWidget("Mark"),
                              dataColumnWidget("Id"),
                              dataColumnWidget("Major Category"),
                              dataColumnWidget("Major Category Description"),
                              dataColumnWidget("Minor Category"),
                              dataColumnWidget("Minor Category Description"),
                              dataColumnWidget("Tag Number"),
                              dataColumnWidget("Serial Number"),
                              dataColumnWidget("Asset Description"),
                              dataColumnWidget("Asset Type"),
                              dataColumnWidget("Asset Condition"),
                              dataColumnWidget("Manufacturer"),
                              dataColumnWidget("Model Manufacturer"),
                              dataColumnWidget("Region"),
                              dataColumnWidget("Country"),
                              dataColumnWidget("City"),
                              dataColumnWidget("Department Code"),
                              dataColumnWidget("Department Name"),
                              dataColumnWidget("Business Unit"),
                              dataColumnWidget("Building Number"),
                              dataColumnWidget("Floor Number"),
                              dataColumnWidget("Employee Id"),
                              dataColumnWidget("PO Number"),
                              dataColumnWidget("Delivery Note Number"),
                              dataColumnWidget("Supplier"),
                              dataColumnWidget("Invoice Number"),
                              dataColumnWidget("Invoice Date"),
                              dataColumnWidget("Ownership"),
                              dataColumnWidget("Bought"),
                              dataColumnWidget("Terminal Id"),
                              dataColumnWidget("ATM Number"),
                              dataColumnWidget("Location Tag"),
                              dataColumnWidget("Building Name"),
                              dataColumnWidget("Building Address"),
                              dataColumnWidget("User Login Id"),
                              dataColumnWidget("Main Sub Series"),
                              dataColumnWidget(
                                  "Major Categories Plus Miner Categories"),
                              dataColumnWidget("Asset Date Captured"),
                              dataColumnWidget("Asset Time Captured"),
                              dataColumnWidget("Asset Date Scanned"),
                              dataColumnWidget("Asset Time Scanned"),
                              dataColumnWidget("Qty"),
                              dataColumnWidget("Phone Exit Number"),
                              dataColumnWidget("Full Location Details"),
                              dataColumnWidget("Delete Asset"),
                            ],
                            source: AssetDataSource(
                              context: context,
                              assetGenerateModel: assetGenerateModel,
                              isMarked: isMarked,
                              setState: setState,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constant.primaryColor,
                        ),
                        onPressed: () {
                          List<String> _tagNumber = [];
                          List<String> _assetDescription = [];
                          List<String> _barcodeInfo = [];
                          for (int i = 0; i < isMarked.length; i++) {
                            if (isMarked[i]) {
                              _tagNumber.add(assetGenerateModel[i].tagNumber!);
                              _assetDescription
                                  .add(assetGenerateModel[i].aSSETdESCRIPTION!);
                              _barcodeInfo.add(
                                  assetGenerateModel[i].tagNumber! +
                                      " " +
                                      assetGenerateModel[i]
                                          .minorCategoryDescription!);
                            }
                          }
                          if (_tagNumber.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please select at least one asset'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            Get.to(
                              () => BarcodeLabelScreen(
                                tagNumber: _tagNumber,
                                assetDescription: _assetDescription,
                                qrCode: _barcodeInfo,
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Print Asset",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  DataColumn dataColumnWidget(String label) {
    return DataColumn(
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  @override
  void dispose() {
    super.dispose();
    assetGenerateModel.clear();
    isMarked.clear();
  }
}

class AssetDataSource extends DataTableSource {
  final BuildContext context;
  final List<AssetForPrintingModel> assetGenerateModel;
  final List<bool> isMarked;
  final void Function(VoidCallback fn) setState;

  AssetDataSource({
    required this.context,
    required this.assetGenerateModel,
    required this.isMarked,
    required this.setState,
  });

  @override
  DataRow getRow(int index) {
    final asset = assetGenerateModel[index];
    return DataRow(
      cells: [
        DataCell(Checkbox(
          value: isMarked[index],
          onChanged: (value) {
            setState(() {
              isMarked[index] = value!;
            });
          },
        )),
        DataCell(Text((index + 1).toString())),
        DataCell(Text(asset.majorCategory ?? '')),
        DataCell(Text(asset.majorCategoryDescription.toString())),
        DataCell(Text(asset.mInorCategory.toString())),
        DataCell(Text(asset.minorCategoryDescription.toString())),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableText(asset.tagNumber ?? ""),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: asset.tagNumber ?? ""));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tag Number Copied to Clipboard'),
                      backgroundColor: Colors.black,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.copy,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(asset.sERIALnUMBER ?? "")),
        DataCell(Text(asset.aSSETdESCRIPTION ?? "")),
        DataCell(Text(asset.assettYPE ?? "")),
        DataCell(Text(asset.aSSETcONDITION ?? "")),
        DataCell(Text(asset.manufacturer ?? "")),
        DataCell(Text(asset.modelofAsset ?? "")),
        DataCell(Text(asset.rEGION ?? "")),
        DataCell(Text(asset.cOUNTRY ?? "")),
        DataCell(Text(asset.cityName ?? "")),
        DataCell(Text(asset.dao ?? "")),
        DataCell(Text(asset.daoName ?? "")),
        DataCell(Text(asset.businessUnit ?? "")),
        DataCell(Text(asset.bUILDINGNO ?? "")),
        DataCell(Text(asset.fLOORNO ?? "")),
        DataCell(Text(asset.eMPLOYEEID ?? "")),
        DataCell(Text(asset.ponUmber ?? "")),
        DataCell(Text(asset.deliveryNoteNo ?? "")),
        DataCell(Text(asset.supplier ?? "")),
        DataCell(Text(asset.invoiceNo ?? "")),
        DataCell(Text(asset.invoiceDate ?? "")),
        DataCell(Text(asset.ownership ?? "")),
        DataCell(Text(asset.bought ?? "")),
        DataCell(Text(asset.terminalID ?? "")),
        DataCell(Text(asset.aTMNumber ?? "")),
        DataCell(Text(asset.locationTag ?? "")),
        DataCell(Text(asset.buildingName ?? "")),
        DataCell(Text(asset.buildingAddress ?? "")),
        DataCell(Text(asset.userLoginID ?? "")),
        DataCell(Text(asset.mainSubSeriesNo?.toString() ?? "")),
        const DataCell(Text("")),
        DataCell(Text(asset.assetdatecaptured ?? "")),
        DataCell(Text(asset.assetTimeCaptured ?? "")),
        DataCell(Text(asset.assetdatescanned ?? "")),
        DataCell(Text(asset.assettimeScanned ?? "")),
        DataCell(Text(asset.qTY?.toString() ?? "")),
        DataCell(Text(asset.phoneExtNo ?? "")),
        DataCell(Text(asset.fullLocationDetails ?? "")),
        DataCell(
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title:
                      const Text('Are you sure you want to delete this asset?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Constant.showLoadingDialog(context);
                        await DeleteTagServices.deleteTag(
                            asset.tagNumber ?? "");
                        Navigator.pop(context);
                        Navigator.pop(context);

                        setState(() {
                          assetGenerateModel.removeAt(index);
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
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => assetGenerateModel.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => isMarked.where((marked) => marked).length;
}
