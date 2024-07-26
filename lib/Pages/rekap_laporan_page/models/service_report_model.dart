import 'dart:convert';

ServiceReport serviceReportFromJson(String str) => ServiceReport.fromJson(json.decode(str));

String serviceReportToJson(ServiceReport data) => json.encode(data.toJson());

class ServiceReport {
    List<Datum> data;
    String success;

    ServiceReport({
        required this.data,
        required this.success,
    });

    factory ServiceReport.fromJson(Map<String, dynamic> json) => ServiceReport(
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        success: json["Success"],
    );

    Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Success": success,
    };
}

class ServiceReportsItem {
    int serviceReportsItemsId;
    int storeItemsId;
    String itemName;
    int quantity;
    int price;
    String category;
    int categoryId;
    int serviceReportId;
    Datum serviceReports;
    Categories categories;

    ServiceReportsItem({
        required this.serviceReportsItemsId,
        required this.storeItemsId,
        required this.itemName,
        required this.quantity,
        required this.price,
        required this.category,
        required this.categoryId,
        required this.serviceReportId,
        required this.serviceReports,
        required this.categories,
    });

    factory ServiceReportsItem.fromJson(Map<String, dynamic> json) => ServiceReportsItem(
        serviceReportsItemsId: json["service_reports_items_id"],
        storeItemsId: json["store_items_id"],
        itemName: json["item_name"],
        quantity: json["quantity"],
        price: json["price"],
        category: json["category"],
        categoryId: json["category_id"],
        serviceReportId: json["service_report_id"],
        serviceReports: Datum.fromJson(json["ServiceReports"]),
        categories: Categories.fromJson(json["Categories"]),
    );

    Map<String, dynamic> toJson() => {
        "service_reports_items_id": serviceReportsItemsId,
        "store_items_id": storeItemsId,
        "item_name": itemName,
        "quantity": quantity,
        "price": price,
        "category": category,
        "category_id": categoryId,
        "service_report_id": serviceReportId,
        "ServiceReports": serviceReports.toJson(),
        "Categories": categories.toJson(),
    };
}

class Datum {
    int serviceReportId;
    DateTime date;
    String name;
    String machineName;
    String complaints;
    int totalPrice;
    int statusId;
    int userId;
    Status status;
    User user;
    List<ServiceReportsItem> serviceReportsItems;

    Datum({
        required this.serviceReportId,
        required this.date,
        required this.name,
        required this.machineName,
        required this.complaints,
        required this.totalPrice,
        required this.statusId,
        required this.userId,
        required this.status,
        required this.user,
        required this.serviceReportsItems,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serviceReportId: json["service_report_id"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        machineName: json["machine_name"],
        complaints: json["complaints"],
        totalPrice: json["total_price"],
        statusId: json["status_id"],
        userId: json["user_id"],
        status: Status.fromJson(json["Status"]),
        user: User.fromJson(json["User"]),
        serviceReportsItems: json["ServiceReportsItems"] != null 
            ? List<ServiceReportsItem>.from(json["ServiceReportsItems"].map((x) => ServiceReportsItem.fromJson(x))) 
            : [],
    );

    Map<String, dynamic> toJson() => {
        "service_report_id": serviceReportId,
        "date": date.toIso8601String(),
        "name": name,
        "machine_name": machineName,
        "complaints": complaints,
        "total_price": totalPrice,
        "status_id": statusId,
        "user_id": userId,
        "Status": status.toJson(),
        "User": user.toJson(),
        "ServiceReportsItems": List<dynamic>.from(serviceReportsItems.map((x) => x.toJson())),
    };
}


class Categories {
    int categoryId;
    String categoryName;
    dynamic sparePart;
    dynamic storeItems;

    Categories({
        required this.categoryId,
        required this.categoryName,
        required this.sparePart,
        required this.storeItems,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        sparePart: json["SparePart"],
        storeItems: json["StoreItems"],
    );

    Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "SparePart": sparePart,
        "StoreItems": storeItems,
    };
}

class Status {
    int serviceReportId;
    String statusName;
    dynamic serviceReports;

    Status({
        required this.serviceReportId,
        required this.statusName,
        required this.serviceReports,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        serviceReportId: json["service_report_id"],
        statusName: json["status_name"],
        serviceReports: json["ServiceReports"],
    );

    Map<String, dynamic> toJson() => {
        "service_report_id": serviceReportId,
        "status_name": statusName,
        "ServiceReports": serviceReports,
    };
}

class User {
    int userId;
    String image;
    String username;
    String password;
    String address;
    String noHandphone;
    int roleId;
    Role role;

    User({
        required this.userId,
        required this.image,
        required this.username,
        required this.password,
        required this.address,
        required this.noHandphone,
        required this.roleId,
        required this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        image: json["image"],
        username: json["username"],
        password: json["password"],
        address: json["address"],
        noHandphone: json["no_handphone"],
        roleId: json["role_id"],
        role: Role.fromJson(json["Role"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "image": image,
        "username": username,
        "password": password,
        "address": address,
        "no_handphone": noHandphone,
        "role_id": roleId,
        "Role": role.toJson(),
    };
}

class Role {
    int roleId;
    String roleName;
    dynamic user;

    Role({
        required this.roleId,
        required this.roleName,
        required this.user,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["role_id"],
        roleName: json["role_name"],
        user: json["User"],
    );

    Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "role_name": roleName,
        "User": user,
    };
}
