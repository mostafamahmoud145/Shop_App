class FavoriteModel {
late bool status;
late Null message;
late Data data;

FavoriteModel.fromJson(Map<String, dynamic> json) {
status = json['status'];
message = json['message'];
data = Data.fromJson(json['data']);
}

}

class Data {
  late int currentPage;
  late List<FavoriteData> data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavoriteData>[];
      json['data'].forEach((v) { data.add(new FavoriteData.fromJson(v)); });
    }
  }
}

class FavoriteData {
  late int id;
  late Product product;

  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
