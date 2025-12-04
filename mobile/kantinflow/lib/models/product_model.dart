class ProductModel {
  final int id;
  final String name;
  final String? photoUrl;
  final double sellingPrice;
  final int quantity;
  final String? currency;
  final int uploadedBy;

  const ProductModel({
    required this.id,
    required this.name,
    required this.sellingPrice,
    required this.quantity,
    required this.uploadedBy,
    this.currency,
    this.photoUrl
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"], 
    name: json["name"], 
    sellingPrice: json["sellingPrice"], 
    quantity: json["quantity"], 
    uploadedBy: json["uploadedBy"],
    currency: json["currency"],
    photoUrl: json["photoUrl"]
  );

  Map<String,dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "SellingPrice": sellingPrice,
    "Quantity": quantity,
    "UploadedBy": uploadedBy,
    "Currency": currency,
    "PhotoUrl": photoUrl
  };
}