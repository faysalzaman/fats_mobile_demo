class AssetGenerateModel {
  int? tblAssetMasterEncodeAssetCaptureID;
  String? majorCategory;
  String? majorCategoryDescription;
  String? mInorCategory;
  String? minorCategoryDescription;
  String? tagNumber;
  String? sERIALnUMBER;
  String? aSSETdESCRIPTION;
  String? assettYPE;
  String? aSSETcONDITION;
  String? cOUNTRY;
  String? rEGION;
  String? cityName;
  String? dao;
  String? daoName;
  String? businessUnit;
  String? bUILDINGNO;
  String? fLOORNO;
  String? eMPLOYEEID;
  String? ponUmber;
  String? podate;
  String? deliveryNoteNo;
  String? supplier;
  String? invoiceNo;
  String? invoiceDate;
  String? modelofAsset;
  String? manufacturer;
  String? ownership;
  String? bought;
  String? terminalID;
  String? aTMNumber;
  String? locationTag;
  String? buildingName;
  String? buildingAddress;
  String? userLoginID;
  int? mainSubSeriesNo;
  String? assetdatecaptured;
  String? assetTimeCaptured;
  String? assetdatescanned;
  String? assettimeScanned;
  int? qTY;
  String? phoneExtNo;
  String? fullLocationDetails;

  AssetGenerateModel(
      {this.tblAssetMasterEncodeAssetCaptureID,
      this.majorCategory,
      this.majorCategoryDescription,
      this.mInorCategory,
      this.minorCategoryDescription,
      this.tagNumber,
      this.sERIALnUMBER,
      this.aSSETdESCRIPTION,
      this.assettYPE,
      this.aSSETcONDITION,
      this.cOUNTRY,
      this.rEGION,
      this.cityName,
      this.dao,
      this.daoName,
      this.businessUnit,
      this.bUILDINGNO,
      this.fLOORNO,
      this.eMPLOYEEID,
      this.ponUmber,
      this.podate,
      this.deliveryNoteNo,
      this.supplier,
      this.invoiceNo,
      this.invoiceDate,
      this.modelofAsset,
      this.manufacturer,
      this.ownership,
      this.bought,
      this.terminalID,
      this.aTMNumber,
      this.locationTag,
      this.buildingName,
      this.buildingAddress,
      this.userLoginID,
      this.mainSubSeriesNo,
      this.assetdatecaptured,
      this.assetTimeCaptured,
      this.assetdatescanned,
      this.assettimeScanned,
      this.qTY,
      this.phoneExtNo,
      this.fullLocationDetails});

  AssetGenerateModel.fromJson(Map<String, dynamic> json) {
    tblAssetMasterEncodeAssetCaptureID =
        json['TblAssetMasterEncodeAssetCaptureID'];
    majorCategory = json['MajorCategory'];
    majorCategoryDescription = json['MajorCategoryDescription'];
    mInorCategory = json['MInorCategory'];
    minorCategoryDescription = json['MinorCategoryDescription'];
    tagNumber = json['TagNumber'];
    sERIALnUMBER = json['sERIALnUMBER'];
    aSSETdESCRIPTION = json['aSSETdESCRIPTION'];
    assettYPE = json['assettYPE'];
    aSSETcONDITION = json['aSSETcONDITION'];
    cOUNTRY = json['cOUNTRY'];
    rEGION = json['rEGION'];
    cityName = json['CityName'];
    dao = json['Dao'];
    daoName = json['DaoName'];
    businessUnit = json['BusinessUnit'];
    bUILDINGNO = json['BUILDINGNO'];
    fLOORNO = json['FLOORNO'];
    eMPLOYEEID = json['EMPLOYEEID'];
    ponUmber = json['ponUmber'];
    podate = json['Podate'];
    deliveryNoteNo = json['DeliveryNoteNo'];
    supplier = json['Supplier'];
    invoiceNo = json['InvoiceNo'];
    invoiceDate = json['InvoiceDate'];
    modelofAsset = json['ModelofAsset'];
    manufacturer = json['Manufacturer'];
    ownership = json['Ownership'];
    bought = json['Bought'];
    terminalID = json['TerminalID'];
    aTMNumber = json['ATMNumber'];
    locationTag = json['LocationTag'];
    buildingName = json['buildingName'];
    buildingAddress = json['buildingAddress'];
    userLoginID = json['UserLoginID'];
    mainSubSeriesNo = json['MainSubSeriesNo'];
    assetdatecaptured = json['assetdatecaptured'];
    assetTimeCaptured = json['assetTimeCaptured'];
    assetdatescanned = json['assetdatescanned'];
    assettimeScanned = json['assettimeScanned'];
    qTY = json['QTY'];
    phoneExtNo = json['PhoneExtNo'];
    fullLocationDetails = json['FullLocationDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TblAssetMasterEncodeAssetCaptureID'] =
        tblAssetMasterEncodeAssetCaptureID;
    data['MajorCategory'] = majorCategory;
    data['MajorCategoryDescription'] = majorCategoryDescription;
    data['MInorCategory'] = mInorCategory;
    data['MinorCategoryDescription'] = minorCategoryDescription;
    data['TagNumber'] = tagNumber;
    data['sERIALnUMBER'] = sERIALnUMBER;
    data['aSSETdESCRIPTION'] = aSSETdESCRIPTION;
    data['assettYPE'] = assettYPE;
    data['aSSETcONDITION'] = aSSETcONDITION;
    data['cOUNTRY'] = cOUNTRY;
    data['rEGION'] = rEGION;
    data['CityName'] = cityName;
    data['Dao'] = dao;
    data['DaoName'] = daoName;
    data['BusinessUnit'] = businessUnit;
    data['BUILDINGNO'] = bUILDINGNO;
    data['FLOORNO'] = fLOORNO;
    data['EMPLOYEEID'] = eMPLOYEEID;
    data['ponUmber'] = ponUmber;
    data['Podate'] = podate;
    data['DeliveryNoteNo'] = deliveryNoteNo;
    data['Supplier'] = supplier;
    data['InvoiceNo'] = invoiceNo;
    data['InvoiceDate'] = invoiceDate;
    data['ModelofAsset'] = modelofAsset;
    data['Manufacturer'] = manufacturer;
    data['Ownership'] = ownership;
    data['Bought'] = bought;
    data['TerminalID'] = terminalID;
    data['ATMNumber'] = aTMNumber;
    data['LocationTag'] = locationTag;
    data['buildingName'] = buildingName;
    data['buildingAddress'] = buildingAddress;
    data['UserLoginID'] = userLoginID;
    data['MainSubSeriesNo'] = mainSubSeriesNo;
    data['assetdatecaptured'] = assetdatecaptured;
    data['assetTimeCaptured'] = assetTimeCaptured;
    data['assetdatescanned'] = assetdatescanned;
    data['assettimeScanned'] = assettimeScanned;
    data['QTY'] = qTY;
    data['PhoneExtNo'] = phoneExtNo;
    data['FullLocationDetails'] = fullLocationDetails;
    return data;
  }
}
