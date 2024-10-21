import 'package:fats_mobile_demo/constants.dart';
import 'package:flutter/material.dart';

class RectifyAssetsByEmployee extends StatefulWidget {
  const RectifyAssetsByEmployee({super.key});

  @override
  State<RectifyAssetsByEmployee> createState() =>
      _RectifyAssetsByEmployeeState();
}

class _RectifyAssetsByEmployeeState extends State<RectifyAssetsByEmployee> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rectify Assets by Employee'),
        backgroundColor: Constant.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Employee ID',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Employee Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(width: 8),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "** Click here to ADD new Asset **",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Paginated Table
                Row(
                  children: [
                    Expanded(
                      child: PaginatedDataTable(
                        header: const Text(
                          'Asset Details',
                        ),
                        arrowHeadColor: Colors.white,
                        headingRowColor: MaterialStateProperty.all(
                          Constant.primaryColor,
                        ),
                        rowsPerPage: _rowsPerPage,
                        onRowsPerPageChanged: (int? value) {
                          setState(() {
                            _rowsPerPage = value!;
                          });
                        },
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                        onSelectAll: (bool? value) {},
                        columns: <DataColumn>[
                          DataColumn(
                            label: const Text(
                              'Name',
                              style: TextStyle(color: Colors.white),
                            ),
                            onSort: (int columnIndex, bool ascending) {
                              setState(() {
                                _sortColumnIndex = columnIndex;
                                _sortAscending = ascending;
                              });
                            },
                          ),
                          const DataColumn(
                            label: Text(
                              'Age',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                        source: MyTableSource(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "** Click here to REMOVE the Asset **",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Back"),
                    ),
                    Row(
                      children: [
                        const Text("Total Assets"),
                        const SizedBox(width: 8),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "10",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTableSource extends DataTableSource {
  // Sample data for demonstration
  final List<Map<String, dynamic>> _data = [
    {'name': 'John', 'age': 30},
    {'name': 'Alice', 'age': 25},
    {'name': 'Bob', 'age': 40},
    // Add more data as needed
  ];

  @override
  DataRow getRow(int index) {
    final row = _data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row['name'])),
        DataCell(Text('${row['age']}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0; // You can implement selection if needed
}
