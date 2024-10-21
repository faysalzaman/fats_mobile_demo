import 'package:fats_mobile_demo/Services/VarifiedAsset/VarifiedAssetServices.dart';
import 'package:fats_mobile_demo/models/VarifiedAssetModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Services/AssetVarification/DeleteTag.dart';
import '../../constants.dart';
import '../AssetForPrinting/BarcodeLabelScreen.dart';

class VarifiedAssetScreen extends StatefulWidget {
  const VarifiedAssetScreen({super.key});

  @override
  State<VarifiedAssetScreen> createState() => _VarifiedAssetScreenState();
}

class _VarifiedAssetScreenState extends State<VarifiedAssetScreen> {
  List<VarifiedAssetModel> varifiedAssetModel = [];
  List<bool> isMarked = [];
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        VarifiedAssetServices.varifiedAsset().then(
          (response) {
            varifiedAssetModel = response;
            for (int i = 0; i < varifiedAssetModel.length; i++) {
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

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verified Assets'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Constant.primaryColor,
        foregroundColor: Colors.white,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     List<String> _tagNumber = [];
      //     List<String> _assetDescription = [];
      //     List<String> _barcodeInfo = [];

      //     for (int i = 0; i < isMarked.length; i++) {
      //       if (isMarked[i]) {
      //         _tagNumber.add(varifiedAssetModel[i].tagNumber!);
      //         _assetDescription.add(varifiedAssetModel[i].aSSETdESCRIPTION!);
      //         _barcodeInfo.add("${varifiedAssetModel[i].tagNumber!} " +
      //             varifiedAssetModel[i].minorCategoryDescription!);
      //       }
      //     }

      //     if (_tagNumber.isEmpty) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           content: Text('Please select at least one asset'),
      //           backgroundColor: Colors.red,
      //         ),
      //       );
      //     } else {
      //       Get.to(() => BarcodeLabelScreen(
      //             tagNumber: _tagNumber,
      //             assetDescription: _assetDescription,
      //             qrCode: _barcodeInfo,
      //           ));
      //     }
      //   },
      //   label: const Text('Print Asset'),
      //   icon: const Icon(Icons.print),
      // ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Constant.primaryColor,
                strokeWidth: 10,
                strokeCap: StrokeCap.round,
              ),
            )
          : varifiedAssetModel.isEmpty
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
                              'Verified Assets',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            headingRowColor: MaterialStateProperty.all(
                                Constant.primaryColor),
                            rowsPerPage: rowsPerPage,
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                rowsPerPage = value ??
                                    PaginatedDataTable.defaultRowsPerPage;
                              });
                            },
                            columns: [
                              dataColumWidget("Mark"),
                              dataColumWidget("Id"),
                              dataColumWidget("Major Category"),
                              dataColumWidget("Major Category Description"),
                              dataColumWidget("Minor Category"),
                              dataColumWidget("Minor Category Description"),
                              dataColumWidget("Tag Number"),
                              dataColumWidget("Serial Number"),
                              dataColumWidget("Asset Description"),
                              dataColumWidget("Asset Type"),
                              dataColumWidget("Asset Condition"),
                              dataColumWidget("Manufacturer"),
                              dataColumWidget("Model Manufacturer"),
                              dataColumWidget("Country"),
                              dataColumWidget("City"),
                              dataColumWidget("Region"),
                              dataColumWidget("Department Code"),
                              dataColumWidget("Department Name"),
                              dataColumWidget("Business Unit"),
                              dataColumWidget("Building Number"),
                              dataColumWidget("Floor Number"),
                              dataColumWidget("Employee Id"),
                              dataColumWidget("PO Number"),
                              dataColumWidget("Delivery Note Number"),
                              dataColumWidget("Supplier"),
                              dataColumWidget("Invoice Number"),
                              dataColumWidget("Invoice Date"),
                              dataColumWidget("Ownership"),
                              dataColumWidget("Bought"),
                              dataColumWidget("Terminal Id"),
                              dataColumWidget("ATM Number"),
                              dataColumWidget("Location Tag"),
                              dataColumWidget("Building Name"),
                              dataColumWidget("Building Address"),
                              dataColumWidget("User Login Id"),
                              dataColumWidget("Main Sub Series"),
                              dataColumWidget(
                                  "Major Categories Plus Minor Categories"),
                              dataColumWidget("Asset Date Captured"),
                              dataColumWidget("Asset Time Captured"),
                              dataColumWidget("Asset Date Scanned"),
                              dataColumWidget("Asset Time Scanned"),
                              dataColumWidget("Qty"),
                              dataColumWidget("Phone Exit Number"),
                              dataColumWidget("Full Location Details"),
                              dataColumWidget("Journal Ref No"),
                              dataColumWidget("Images"),
                              dataColumWidget("Delete"),
                            ],
                            source: VarifiedAssetDataSource(
                                context: context,
                                varifiedAssetModel: varifiedAssetModel,
                                isMarked: isMarked,
                                setState: setState),
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
                              _tagNumber.add(varifiedAssetModel[i].tagNumber!);
                              _assetDescription
                                  .add(varifiedAssetModel[i].aSSETdESCRIPTION!);
                              _barcodeInfo.add(
                                  "${varifiedAssetModel[i].tagNumber!} " +
                                      varifiedAssetModel[i]
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
                            Get.to(() => BarcodeLabelScreen(
                                  tagNumber: _tagNumber,
                                  assetDescription: _assetDescription,
                                  qrCode: _barcodeInfo,
                                ));
                          }
                        },
                        child: const Text(
                          'Print Asset',
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

  DataColumn dataColumWidget(String label) {
    return DataColumn(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class VarifiedAssetDataSource extends DataTableSource {
  final BuildContext context;
  final List<VarifiedAssetModel> varifiedAssetModel;
  final List<bool> isMarked;
  final void Function(VoidCallback fn) setState;

  VarifiedAssetDataSource({
    required this.context,
    required this.varifiedAssetModel,
    required this.isMarked,
    required this.setState,
  });

  @override
  DataRow getRow(int index) {
    final asset = varifiedAssetModel[index];
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
        DataCell(Text(asset.majorCategoryDescription ?? '')),
        DataCell(Text(asset.mInorCategory ?? '')),
        DataCell(Text(asset.minorCategoryDescription ?? '')),
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
        DataCell(Text(asset.sERIALnUMBER ?? '')),
        DataCell(Text(asset.aSSETdESCRIPTION ?? '')),
        DataCell(Text(asset.assettYPE ?? '')),
        DataCell(Text(asset.aSSETcONDITION ?? '')),
        DataCell(Text(asset.manufacturer ?? '')),
        DataCell(Text(asset.modelofAsset ?? '')),
        DataCell(Text(asset.rEGION ?? '')),
        DataCell(Text(asset.cOUNTRY ?? '')),
        DataCell(Text(asset.cityName ?? '')),
        DataCell(Text(asset.dao ?? '')),
        DataCell(Text(asset.daoName ?? '')),
        DataCell(Text(asset.businessUnit ?? '')),
        DataCell(Text(asset.bUILDINGNO ?? '')),
        DataCell(Text(asset.fLOORNO ?? '')),
        DataCell(Text(asset.eMPLOYEEID ?? '')),
        DataCell(Text(asset.ponUmber ?? '')),
        DataCell(Text(asset.deliveryNoteNo ?? '')),
        DataCell(Text(asset.supplier ?? '')),
        DataCell(Text(asset.invoiceNo ?? '')),
        DataCell(Text(asset.invoiceDate ?? '')),
        DataCell(Text(asset.ownership ?? '')),
        DataCell(Text(asset.bought ?? '')),
        DataCell(Text(asset.terminalID ?? '')),
        DataCell(Text(asset.aTMNumber ?? '')),
        DataCell(Text(asset.locationTag ?? '')),
        DataCell(Text(asset.buildingName ?? '')),
        DataCell(Text(asset.buildingAddress ?? '')),
        DataCell(Text(asset.userLoginID ?? '')),
        DataCell(Text(asset.mainSubSeriesNo?.toString() ?? '')),
        const DataCell(Text('')),
        DataCell(Text(asset.assetdatecaptured ?? '')),
        DataCell(Text(asset.assetTimeCaptured ?? '')),
        DataCell(Text(asset.assetdatescanned ?? '')),
        DataCell(Text(asset.assettimeScanned ?? '')),
        DataCell(Text(asset.qTY?.toString() ?? '')),
        DataCell(Text(asset.phoneExtNo ?? '')),
        DataCell(Text(asset.fullLocationDetails ?? '')),
        DataCell(Text(asset.journalRefNo ?? '')),
        DataCell(Text(asset.images ?? '')),
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
                            asset.tagNumber ?? '');
                        Navigator.pop(context);
                        Navigator.pop(context);

                        setState(() {
                          varifiedAssetModel.removeAt(index);
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
  int get rowCount => varifiedAssetModel.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => isMarked.where((marked) => marked).length;
}
