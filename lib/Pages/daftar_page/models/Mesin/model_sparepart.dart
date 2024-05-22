class SparepartItem {
  final int sparepartItemsId;
  final String sparepartItemsName;
  final int quantity;
  final int price;
  final int categorySparepartId;

  SparepartItem({
    required this.sparepartItemsId,
    required this.sparepartItemsName,
    required this.quantity,
    required this.price,
    required this.categorySparepartId,
  });

  factory SparepartItem.fromJson(Map<String, dynamic> json) {
    return SparepartItem(
      sparepartItemsId: json['spare_part_id'],
      sparepartItemsName: json['spare_part_name'],
      quantity: json['quantity'],
      price: json['price'],
      categorySparepartId: json['category_spare_part_id'],
    );
  }
}

class CategorySparepart {
  final int categorySparepartId;
  final String categorySparepartName;

  CategorySparepart({
    required this.categorySparepartId,
    required this.categorySparepartName,
  });

  factory CategorySparepart.fromJson(Map<String, dynamic> json) {
    return CategorySparepart(
      categorySparepartId: json['category_spare_part_id'],
      categorySparepartName: json['category_spare_part_name'],
    );
  }
}
