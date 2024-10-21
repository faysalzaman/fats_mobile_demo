class CountriesListModel {
  int? tblCountryID;
  String? countryCode;
  String? countryName;

  CountriesListModel({this.tblCountryID, this.countryCode, this.countryName});

  CountriesListModel.fromJson(Map<String, dynamic> json) {
    tblCountryID = json['TblCountryID'];
    countryCode = json['CountryCode'];
    countryName = json['CountryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TblCountryID'] = tblCountryID;
    data['CountryCode'] = countryCode;
    data['CountryName'] = countryName;
    return data;
  }
}
