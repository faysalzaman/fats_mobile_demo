// ignore_for_file: file_names

class POMasterModel {
  num? id;
  String? pONo;
  num? revisionNo;
  String? subject;
  String? contractRefNo;
  String? buyerEmail;
  String? customer;
  String? customerAddress;
  String? pOIssueDate;
  String? paymentTerms;
  String? quotationRefNo;
  String? pOCurrency;
  String? incoterms;
  String? customerTRN;
  String? supplierName;
  String? supplierPhone;
  String? supplierContactName;
  String? supplierEmail;
  String? createdAt;
  String? updatedAt;

  POMasterModel(
      {this.id,
      this.pONo,
      this.revisionNo,
      this.subject,
      this.contractRefNo,
      this.buyerEmail,
      this.customer,
      this.customerAddress,
      this.pOIssueDate,
      this.paymentTerms,
      this.quotationRefNo,
      this.pOCurrency,
      this.incoterms,
      this.customerTRN,
      this.supplierName,
      this.supplierPhone,
      this.supplierContactName,
      this.supplierEmail,
      this.createdAt,
      this.updatedAt});

  POMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pONo = json['PONo'];
    revisionNo = json['RevisionNo'];
    subject = json['Subject'];
    contractRefNo = json['ContractRefNo'];
    buyerEmail = json['BuyerEmail'];
    customer = json['Customer'];
    customerAddress = json['CustomerAddress'];
    pOIssueDate = json['POIssueDate'];
    paymentTerms = json['PaymentTerms'];
    quotationRefNo = json['QuotationRefNo'];
    pOCurrency = json['POCurrency'];
    incoterms = json['Incoterms'];
    customerTRN = json['CustomerTRN'];
    supplierName = json['SupplierName'];
    supplierPhone = json['SupplierPhone'];
    supplierContactName = json['SupplierContactName'];
    supplierEmail = json['SupplierEmail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['PONo'] = pONo;
    data['RevisionNo'] = revisionNo;
    data['Subject'] = subject;
    data['ContractRefNo'] = contractRefNo;
    data['BuyerEmail'] = buyerEmail;
    data['Customer'] = customer;
    data['CustomerAddress'] = customerAddress;
    data['POIssueDate'] = pOIssueDate;
    data['PaymentTerms'] = paymentTerms;
    data['QuotationRefNo'] = quotationRefNo;
    data['POCurrency'] = pOCurrency;
    data['Incoterms'] = incoterms;
    data['CustomerTRN'] = customerTRN;
    data['SupplierName'] = supplierName;
    data['SupplierPhone'] = supplierPhone;
    data['SupplierContactName'] = supplierContactName;
    data['SupplierEmail'] = supplierEmail;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
