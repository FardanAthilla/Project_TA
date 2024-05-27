class SelectedItems {
    int id;
    String item;
    int price;
    String category;
    int categoryItemsId;
    int quantity;

    SelectedItems({
        required this.id,
        required this.item,
        required this.price,
        required this.category,
        required this.categoryItemsId,
        required this.quantity,
    });

    factory SelectedItems.fromJson(Map<String, dynamic> json) => SelectedItems(
        id: json["id"],
        item: json["item"],
        price: json["price"],
        category: json["category"],
        categoryItemsId: json["category_items_id"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item": item,
        "price": price,
        "category": category,
        "category_items_id": categoryItemsId,
        "quantity": quantity,
    };
}
