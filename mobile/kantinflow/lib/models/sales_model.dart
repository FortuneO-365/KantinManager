class SalesModel {
  final int id;
  final int productId;
  final int quantitySold;
  final double unitPrice;
  final double totalPrice;
  final DateTime saleDate;
  final int uploadedBy;

  const SalesModel ({
    required this.id,
    required this.productId,
    required this.quantitySold,
    required this.unitPrice,
    required this.totalPrice,
    required this.saleDate,
    required this.uploadedBy
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(
    id: json["id"], 
    productId: json["productId"], 
    quantitySold: json["quantitySold"], 
    unitPrice: json["unitPrice"], 
    totalPrice: json["totalPrice"], 
    saleDate: json["saleDate"], 
    uploadedBy: json["uploadedBy"]
  );

  Map<String, dynamic> toJson() =>{
    "Id": id,
    "productId": productId,
    "quantitySold": quantitySold,
    "unitPrice": unitPrice,
    "totalPrice": totalPrice,
    "saleDate": saleDate,
    "uploadedBy": uploadedBy
  };
}
