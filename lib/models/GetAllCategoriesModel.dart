class GetAllCategoriesModel {
  int? tblMAINSUBSeriesNoID;
  String? mainCategoryCode;
  String? subCategoryCode;
  int? mainSubSeriesNo;
  String? mainDescription;
  String? subDescription;
  int? seriesNumber;

  GetAllCategoriesModel(
      {this.tblMAINSUBSeriesNoID,
      this.mainCategoryCode,
      this.subCategoryCode,
      this.mainSubSeriesNo,
      this.mainDescription,
      this.subDescription,
      this.seriesNumber});

  GetAllCategoriesModel.fromJson(Map<String, dynamic> json) {
    tblMAINSUBSeriesNoID = json['TblMAINSUBSeriesNoID'];
    mainCategoryCode = json['MainCategoryCode'];
    subCategoryCode = json['SubCategoryCode'];
    mainSubSeriesNo = json['MainSubSeriesNo'];
    mainDescription = json['MainDescription'];
    subDescription = json['SubDescription'];
    seriesNumber = json['SeriesNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TblMAINSUBSeriesNoID'] = tblMAINSUBSeriesNoID;
    data['MainCategoryCode'] = mainCategoryCode;
    data['SubCategoryCode'] = subCategoryCode;
    data['MainSubSeriesNo'] = mainSubSeriesNo;
    data['MainDescription'] = mainDescription;
    data['SubDescription'] = subDescription;
    data['SeriesNumber'] = seriesNumber;
    return data;
  }
}
