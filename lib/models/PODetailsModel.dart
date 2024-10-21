class PODetailsModel {
  num? id;
  num? pOMasterID;
  String? itemDescription;
  String? deliveryDate;
  num? quantity;
  String? uOM;
  num? price;
  String? pricePer;
  num? totalPrice;
  String? createdAt;
  String? updatedAt;

  PODetailsModel(
      {this.id,
      this.pOMasterID,
      this.itemDescription,
      this.deliveryDate,
      this.quantity,
      this.uOM,
      this.price,
      this.pricePer,
      this.totalPrice,
      this.createdAt,
      this.updatedAt});

  PODetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pOMasterID = json['POMasterID'];
    itemDescription = json['ItemDescription'];
    deliveryDate = json['DeliveryDate'];
    quantity = json['Quantity'];
    uOM = json['UOM'];
    price = json['Price'];
    pricePer = json['PricePer'];
    totalPrice = json['TotalPrice'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['POMasterID'] = pOMasterID;
    data['ItemDescription'] = itemDescription;
    data['DeliveryDate'] = deliveryDate;
    data['Quantity'] = quantity;
    data['UOM'] = uOM;
    data['Price'] = price;
    data['PricePer'] = pricePer;
    data['TotalPrice'] = totalPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
