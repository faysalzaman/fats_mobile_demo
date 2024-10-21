import 'package:fats_mobile_demo/Services/AssetGenerate/GenerateTags.dart';
import 'package:fats_mobile_demo/models/AssetGenerateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Services/AssetGenerate/NewAssetTagGenerateServices.dart';
import '../../constants.dart';

class NewAssetGenerateTagScreen extends StatefulWidget {
  const NewAssetGenerateTagScreen({Key? key}) : super(key: key);

  @override
  State<NewAssetGenerateTagScreen> createState() =>
      _NewAssetGenerateTagScreenState();
}

class _NewAssetGenerateTagScreenState extends State<NewAssetGenerateTagScreen> {
  List<AssetGenerateModel> assetGenerateModel = [];
  List<bool> isMarked = [];
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Future.delayed(Duration.zero, () {
      NewAssetTagGenerateServices.tagGenerate().then(
        (response) {
          setState(() {
            assetGenerateModel = response;
            isMarked =
                List.generate(assetGenerateModel.length, (index) => false);

            // reverse the list to show the latest data first
            assetGenerateModel = assetGenerateModel.reversed.toList();
            isLoading = false;
          });
        },
      ).onError((error, stackTrace) {
        Navigator.pop(context);
        print("Error is: $error");
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Generate New Tags'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Constant.primaryColor,
        foregroundColor: Colors.white,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      // onPressed: () {
      //   Constant.showLoadingDialog(context);
      //   GenerateTagsServices.tagGenerate(context);
      // },
      //   label: const Text('Generate Tags'),
      // ),
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
                              'Generated Asset Tags',
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
                              DataColumn(
                                  label: const Text('Mark',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Id',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Major Category',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text(
                                      'Major Category Description',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Minor Category',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text(
                                      'Minor Category Description',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Tag Number',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Serial Number',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Asset Description',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Asset Type',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Asset Condition',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Manufacturer',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Model Manufacturer',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Region',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Country',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('City',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Department Code',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Department Name',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Business Unit',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Building Number',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Floor Number',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Employee Id',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('PO Number',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Delivery Note Number',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Supplier',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Invoice Number',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Invoice Date',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Ownership',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Bought',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Terminal Id',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('ATM Number',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Location Tag',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Building Name',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Building Address',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('User Login Id',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Main Sub Series',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Asset Date Captured',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Asset Time Captured',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Asset Date Scanned',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Asset Time Scanned',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Qty',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Phone Exit Number',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: const Text('Full Location Details',
                                      style: TextStyle(color: Colors.white))),
                            ],
                            source: _DataSource(
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
                          // if not selected then return get.snackbar
                          if (isMarked.where((marked) => marked).isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please select at least one item'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          Constant.showLoadingDialog(context);
                          GenerateTagsServices.tagGenerate(context);
                        },
                        child: const Text(
                          'Generate Tags',
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

  DataColumn dataColumn(String label) {
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

class _DataSource extends DataTableSource {
  final BuildContext context;
  final List<AssetGenerateModel> assetGenerateModel;
  final List<bool> isMarked;
  final void Function(VoidCallback fn) setState;

  _DataSource({
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
        DataCell(
          Checkbox(
            value: isMarked[index],
            onChanged: (value) {
              setState(() {
                isMarked[index] = value!;
              });
            },
          ),
        ),
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
