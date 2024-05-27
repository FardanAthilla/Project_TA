class SalesReport {
  int salesReportId;
  DateTime date;
  List<SalesReportItem> salesReportItems;

  SalesReport({
    required this.salesReportId,
    required this.date,
    required this.salesReportItems,
  });

  factory SalesReport.fromJson(Map<String, dynamic> json) {
    return SalesReport(
      salesReportId: json['sales_report_id'],
      date: DateTime.parse(json['date']),
      salesReportItems: List<SalesReportItem>.from(json['SalesReportItems'].map((x) => SalesReportItem.fromJson(x))),
    );
  }
}

class SalesReportItem {
  int salesReportItemsId;
  int storeItemsId;
  String itemName;
  int quantity;
  double price;
  String category;
  int categoryMachineId;

  SalesReportItem({
    required this.salesReportItemsId,
    required this.storeItemsId,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.category,
    required this.categoryMachineId,
  });

  factory SalesReportItem.fromJson(Map<String, dynamic> json) {
    return SalesReportItem(
      salesReportItemsId: json['sales_report_items_id'],
      storeItemsId: json['store_items_id'],
      itemName: json['item_name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      category: json['category'],
      categoryMachineId: json['category_machine_id'],
    );
  }
}
