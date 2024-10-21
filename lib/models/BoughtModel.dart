class BoughtModel {
  int? tblAssetConditionID;
  String? tblConditionCodeBought;
  String? tblConditionDescriptionBought;

  BoughtModel(
      {this.tblAssetConditionID,
      this.tblConditionCodeBought,
      this.tblConditionDescriptionBought});

  BoughtModel.fromJson(Map<String, dynamic> json) {
    tblAssetConditionID = json['TblAssetConditionID'];
    tblConditionCodeBought = json['TblConditionCodeBought'];
    tblConditionDescriptionBought = json['TblConditionDescriptionBought'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TblAssetConditionID'] = tblAssetConditionID;
    data['TblConditionCodeBought'] = tblConditionCodeBought;
    data['TblConditionDescriptionBought'] = tblConditionDescriptionBought;
    return data;
  }
}
