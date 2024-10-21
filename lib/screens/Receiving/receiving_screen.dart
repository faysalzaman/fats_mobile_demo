import 'package:fats_mobile_demo/constants.dart';
import 'package:fats_mobile_demo/cubit/receiving/receiving_cubit.dart';
import 'package:fats_mobile_demo/cubit/receiving/receiving_states.dart';
import 'package:fats_mobile_demo/models/PODetailsModel.dart';
import 'package:fats_mobile_demo/screens/Receiving/purchase_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fats_mobile_demo/models/POMasterModel.dart';

class ReceivingScreen extends StatefulWidget {
  const ReceivingScreen({super.key});

  @override
  State<ReceivingScreen> createState() => _ReceivingScreenState();
}

class _ReceivingScreenState extends State<ReceivingScreen> {
  ReceivingCubit cubit = ReceivingCubit();

  @override
  void initState() {
    super.initState();
    cubit.getPOMaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        title: const Text('Receiving'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: BlocConsumer<ReceivingCubit, ReceivingStates>(
        bloc: cubit,
        listener: (context, state) {
          if (state is GetPOMasterErrorState) {
            print(state.error);
          }
        },
        builder: (context, state) {
          if (state is GetPOMasterErrorState) {
            return Center(
              child: Text(
                textAlign: TextAlign.center,
                state.error,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is GetPOMasterLoadingState) {
            return poMasterShimmer();
          }
          return buildPOMasterTable();
        },
      ),
    );
  }

  Widget buildPOMasterTable() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dataTableTheme: DataTableThemeData(
                headingRowColor: WidgetStateProperty.all(Constant.primaryColor),
                headingTextStyle: const TextStyle(color: Colors.white),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: PaginatedDataTable(
                // header: const Text('PO Master',
                //     style: TextStyle(
                //         color: Colors.black, fontWeight: FontWeight.bold)),
                headingRowColor: WidgetStateProperty.all(Constant.primaryColor),
                rowsPerPage: 3,
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(label: Text('Select ')), // Checkbox column
                  DataColumn(label: Text('PO No')),
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Issue Date')),
                  DataColumn(label: Text('Supplier')),
                ],
                source: POMasterDataSource(
                  cubit.poMaster,
                  cubit,
                  onSelectChanged: (POMasterModel? selected) {
                    setState(() {
                      cubit.selectedId = selected?.id.toString() ?? '';
                      print(cubit.selectedId);
                    });
                  },
                  selectedId: cubit.selectedId,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Line Items",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          buildPODetailsTable(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // PO Master quantity
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total SO",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: Text(cubit.poMaster.length.toString()))
                ],
              ),
              // PO Details quantity
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Items",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: Text(cubit.poDetails.length.toString()))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPODetailsTable() {
    return BlocBuilder<ReceivingCubit, ReceivingStates>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GetPODetailsLoadingState) {
          return poDetailsShimmer();
        }
        if (state is GetPODetailsErrorState) {
          return Center(
            child: Text(
              state.error,
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }
        if (state is GetPODetailsSuccessState) {
          return Theme(
            data: Theme.of(context).copyWith(
              dataTableTheme: DataTableThemeData(
                headingRowColor: WidgetStateProperty.all(Constant.primaryColor),
                headingTextStyle: const TextStyle(color: Colors.white),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: PaginatedDataTable(
                // header: const Text('PO Details',
                //     style: TextStyle(
                //         color: Colors.black, fontWeight: FontWeight.bold)),
                headingRowColor: WidgetStateProperty.all(Constant.primaryColor),
                rowsPerPage: 3,
                columns: const [
                  DataColumn(label: Text('Item')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Price')),
                ],
                showCheckboxColumn: false,
                source: PODetailsDataSource(
                  cubit.poDetails,
                  context,
                  cubit.selectedPOMaster!,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget poMasterShimmer() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dataTableTheme: DataTableThemeData(
                headingRowColor: WidgetStateProperty.all(Constant.primaryColor),
                headingTextStyle: const TextStyle(color: Colors.white),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: PaginatedDataTable(
                headingRowColor: WidgetStateProperty.all(Constant.primaryColor),
                rowsPerPage: 3,
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(label: Text('Select')),
                  DataColumn(label: Text('PO No')),
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Issue Date')),
                  DataColumn(label: Text('Supplier')),
                ],
                source: PlaceholderDataSource(3, 5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget poDetailsShimmer() {
    return Theme(
      data: Theme.of(context).copyWith(
        dataTableTheme: DataTableThemeData(
          headingRowColor: WidgetStateProperty.all(Constant.primaryColor),
          headingTextStyle: const TextStyle(color: Colors.white),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: PaginatedDataTable(
          headingRowColor: WidgetStateProperty.all(Constant.primaryColor),
          rowsPerPage: 3,
          columns: const [
            DataColumn(label: Text('Item')),
            DataColumn(label: Text('Quantity')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Price')),
          ],
          showCheckboxColumn: false,
          source: PlaceholderDataSource(3, 4),
        ),
      ),
    );
  }
}

class POMasterDataSource extends DataTableSource {
  final List<POMasterModel> _data;
  final Function(POMasterModel?) onSelectChanged;
  final String selectedId;
  final ReceivingCubit cubit;

  POMasterDataSource(
    this._data,
    this.cubit, {
    required this.onSelectChanged,
    required this.selectedId,
  });

  @override
  DataRow getRow(int index) {
    final item = _data[index];
    final isSelected = item.id.toString() == selectedId;
    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue.withOpacity(0.1);
          }
          return Colors.white;
        },
      ),
      cells: [
        DataCell(Checkbox(
          checkColor: Colors.white,
          overlayColor: WidgetStateProperty.all(Colors.white),
          activeColor: Constant.primaryColor,
          value: isSelected,
          onChanged: (_) {
            onSelectChanged(item);
            cubit.updateSelectedPOMaster(item);
            cubit.getPODetails(item.id.toString());
          },
        )),
        DataCell(
            Text(item.pONo ?? '', style: const TextStyle(color: Colors.black))),
        DataCell(Text(item.customer ?? '',
            style: const TextStyle(color: Colors.black))),
        DataCell(Text(item.pOIssueDate ?? '',
            style: const TextStyle(color: Colors.black))),
        DataCell(Text(item.supplierName ?? '',
            style: const TextStyle(color: Colors.black))),
      ],
      selected: isSelected,
      onSelectChanged: (_) {
        onSelectChanged(item);
        cubit.updateSelectedPOMaster(item);
        cubit.getPODetails(item.id.toString());
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}

class PODetailsDataSource extends DataTableSource {
  final List<PODetailsModel> _data;
  final BuildContext context;
  final POMasterModel poMaster;

  PODetailsDataSource(this._data, this.context, this.poMaster);

  @override
  DataRow getRow(int index) {
    final items = _data;
    return DataRow(
      color: WidgetStateProperty.all(Colors.white),
      cells: [
        DataCell(
          Text(items[index].uOM ?? '',
              style: const TextStyle(color: Colors.black)),
          onDoubleTap: () => _navigateToDetailScreen(items[index], poMaster),
        ),
        DataCell(
          Text(items[index].quantity?.toString() ?? '',
              style: const TextStyle(color: Colors.black)),
          onDoubleTap: () => _navigateToDetailScreen(items[index], poMaster),
        ),
        DataCell(
          Text(items[index].itemDescription ?? '',
              style: const TextStyle(color: Colors.black)),
          onDoubleTap: () => _navigateToDetailScreen(items[index], poMaster),
        ),
        DataCell(
          Text(items[index].price?.toString() ?? '',
              style: const TextStyle(color: Colors.black)),
          onDoubleTap: () => _navigateToDetailScreen(items[index], poMaster),
        ),
      ],
      onSelectChanged: (_) {},
    );
  }

  void _navigateToDetailScreen(PODetailsModel items, POMasterModel poMaster) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PurchaseOrderScreen(
          poDetail: items,
          poMaster: poMaster,
        ),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}

class PlaceholderDataSource extends DataTableSource {
  final int _rowCount;
  final int columnCount;

  PlaceholderDataSource(this._rowCount, this.columnCount);

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: List.generate(
        columnCount,
        (cellIndex) => DataCell(
          Container(
            width: 80,
            height: 20,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  @override
  int get rowCount => _rowCount;
}
