class GetAllDepartmentsModel {
  int? tblNewDepartmentLitID;
  String? branchcode;
  String? dAONumber;
  String? businessUnit;
  String? bUSINESSGROUP;
  String? hRMapping;
  String? daoName;
  String? daoArea;

  GetAllDepartmentsModel(
      {this.tblNewDepartmentLitID,
      this.branchcode,
      this.dAONumber,
      this.businessUnit,
      this.bUSINESSGROUP,
      this.hRMapping,
      this.daoName,
      this.daoArea});

  GetAllDepartmentsModel.fromJson(Map<String, dynamic> json) {
    tblNewDepartmentLitID = json['TblNewDepartmentLitID'];
    branchcode = json['branchcode'];
    dAONumber = json['DAONumber'];
    businessUnit = json['BusinessUnit'];
    bUSINESSGROUP = json['BUSINESSGROUP'];
    hRMapping = json['HRMapping'];
    daoName = json['DaoName'];
    daoArea = json['DaoArea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TblNewDepartmentLitID'] = tblNewDepartmentLitID;
    data['branchcode'] = branchcode;
    data['DAONumber'] = dAONumber;
    data['BusinessUnit'] = businessUnit;
    data['BUSINESSGROUP'] = bUSINESSGROUP;
    data['HRMapping'] = hRMapping;
    data['DaoName'] = daoName;
    data['DaoArea'] = daoArea;
    return data;
  }
}
