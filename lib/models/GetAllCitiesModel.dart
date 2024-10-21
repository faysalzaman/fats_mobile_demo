class GetAllCitiesModel {
  int? id;
  int? tblCountryID;
  String? cityCode;
  String? cityName;
  String? regionCode;

  GetAllCitiesModel({
    this.id,
    this.tblCountryID,
    this.cityCode,
    this.cityName,
    this.regionCode,
  });

  GetAllCitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tblCountryID = json['TblCountryID'];
    cityCode = json['CityCode'];
    cityName = json['CityName'];
    regionCode = json['RegionCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TblCountryID'] = this.tblCountryID;
    data['CityCode'] = this.cityCode;
    data['CityName'] = this.cityName;
    data['RegionCode'] = this.regionCode;
    return data;
  }
}
