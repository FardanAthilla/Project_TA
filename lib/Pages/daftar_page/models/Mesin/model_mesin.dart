class StoreItem {
  final int storeItemsId;
  final String storeItemsName;
  final int quantity;
  final int price;
  final int categoryMachineId;

  StoreItem({
    required this.storeItemsId,
    required this.storeItemsName,
    required this.quantity,
    required this.price,
    required this.categoryMachineId,
  });

  factory StoreItem.fromJson(Map<String, dynamic> json) {
    return StoreItem(
      storeItemsId: json['store_items_id'],
      storeItemsName: json['store_items_name'],
      quantity: json['quantity'],
      price: json['price'],
      categoryMachineId: json['category_id'],
    );
  }
}

class CategoryMachine {
  final int categoryMachineId;
  final String categoryMachineName;

  CategoryMachine({
    required this.categoryMachineId,
    required this.categoryMachineName,
  });

  factory CategoryMachine.fromJson(Map<String, dynamic> json) {
    return CategoryMachine(
      categoryMachineId: json['category_id'],
      categoryMachineName: json['category_name'],
    );
  }
}
