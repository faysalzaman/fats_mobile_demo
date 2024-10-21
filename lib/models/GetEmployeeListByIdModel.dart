class GetEmployeeListByIdModel {
  List<Recordset>? recordset;
  List<int>? rowsAffected;

  GetEmployeeListByIdModel({this.recordset, this.rowsAffected});

  GetEmployeeListByIdModel.fromJson(Map<String, dynamic> json) {
    if (json['recordset'] != null) {
      recordset = <Recordset>[];
      json['recordset'].forEach((v) {
        recordset!.add(Recordset.fromJson(v));
      });
    }
    rowsAffected = json['rowsAffected'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recordset != null) {
      data['recordset'] = recordset!.map((v) => v.toJson()).toList();
    }
    data['rowsAffected'] = rowsAffected;
    return data;
  }
}

class Recordset {
  int? tblEmpAutoID;
  String? empID;
  String? empName;
  String? empRegion;
  String? empUnit;
  String? empDivision;

  Recordset(
      {this.tblEmpAutoID,
      this.empID,
      this.empName,
      this.empRegion,
      this.empUnit,
      this.empDivision});

  Recordset.fromJson(Map<String, dynamic> json) {
    tblEmpAutoID = json['TblEmpAutoID'];
    empID = json['EmpID'];
    empName = json['EmpName'];
    empRegion = json['EmpRegion'];
    empUnit = json['EmpUnit'];
    empDivision = json['EmpDivision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TblEmpAutoID'] = tblEmpAutoID;
    data['EmpID'] = empID;
    data['EmpName'] = empName;
    data['EmpRegion'] = empRegion;
    data['EmpUnit'] = empUnit;
    data['EmpDivision'] = empDivision;
    return data;
  }
}
