class AssetConditionModel {
  int? tblAssetConditionID;
  String? tblConditionCode;
  String? tblConditionDescription;

  AssetConditionModel(
      {this.tblAssetConditionID,
      this.tblConditionCode,
      this.tblConditionDescription});

  AssetConditionModel.fromJson(Map<String, dynamic> json) {
    tblAssetConditionID = json['TblAssetConditionID'];
    tblConditionCode = json['TblConditionCode'];
    tblConditionDescription = json['TblConditionDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TblAssetConditionID'] = tblAssetConditionID;
    data['TblConditionCode'] = tblConditionCode;
    data['TblConditionDescription'] = tblConditionDescription;
    return data;
  }
}
