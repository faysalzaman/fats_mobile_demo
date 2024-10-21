class GetAllEmployeesModel {
  int? tblEmpAutoID;
  String? empID;
  String? empName;
  String? empRegion;
  String? empUnit;
  String? empDivision;

  GetAllEmployeesModel(
      {this.tblEmpAutoID,
      this.empID,
      this.empName,
      this.empRegion,
      this.empUnit,
      this.empDivision});

  GetAllEmployeesModel.fromJson(Map<String, dynamic> json) {
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
