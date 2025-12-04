import 'package:kantin_management/models/product_model.dart';
import 'package:kantin_management/models/sales_model.dart';

class DashboardStats {
  final int totalProducts;
  final int totalSales;
  final double totalRevenue;
  final double totalMonth;
  final double totalToday;
  final List<ProductModel>? lowStock;
  final List<SalesModel>? todayOrders;

  const DashboardStats({
    required this.totalProducts,
    required this.totalSales,
    required this.totalRevenue,
    required this.totalMonth,
    required this.totalToday,
    this.lowStock,
    this.todayOrders
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) => DashboardStats(
    totalProducts: json["totalProducts"], 
    totalSales: json["totalSales"], 
    totalRevenue: json["totalRevenue"], 
    totalMonth: json["monthlyRevenue"], 
    totalToday: json["todayRevenue"],
    lowStock: (json["lowStockProducts"] as List<dynamic>?)
        ?.map((item) => ProductModel.fromJson(item))
        .toList(),
    todayOrders: (json["todayOrders"] as List<dynamic>?)
        ?.map((item) => SalesModel.fromJson(item))
        .toList(),

  );

  Map<String,dynamic> toJson() => {
    "Total Products": totalProducts,
    "Total Sales": totalSales,
    "Total Revenue": totalRevenue,
    "Monthly Total": totalMonth,
    "Today's Total": totalToday,
    "Low Stock": lowStock,
    "Today's Orders": todayOrders
  };
}