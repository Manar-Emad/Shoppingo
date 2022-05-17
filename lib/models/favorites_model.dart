// import 'package:shop/models/home_model.dart';
//
// class FavoritesModel{
//   late bool status ;
//   Null message;
//   late Data data;
//
//   FavoritesModel.fromJson(Map<String , dynamic> json){
//     status =json['status'] ;
//     message=json['message'];
//     data = (json['data'] != null ? new Data.fromJson(json['data']) :null)! ;
//   }
// }
//
// class Data {
//   late int currentPage;
//   late List<Data>data;
//   late String firstPageUrl;
//   late int from;
//   late int lastPage;
//   late String lastPageUrl;
//   Null nextPageUrl;
//   late String path;
//   late int perPage;
//   Null prevPage;
//   late int to;
//   late int total;
//
//
//   Data.fromJson(Map<String, dynamic>json){
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data.add(new Data.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     lastPage = json['lastPage'];
//     from = json['from'];
//     lastPageUrl = json['lastPageUrl'];
//     nextPageUrl = json['nextPageUrl'];
//     path = json['path'];
//     perPage = json['perPage'];
//     prevPage = json['prevPage'];
//     to = json['to'];
//     total = json['total'];
//   }
// }
//
// class FavData {
//   int id;
//   Product product;
//
//   FavData({this.id, this.product});
//
//   FavData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product =
//     (json['product'] != null ? new Product.fromJson(json['product']) : null)!;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.product != null) {
//       data['product'] = this.product.toJson();
//     }
//     return data;
//   }
// }
// class Product {
// int id;
// dynamic price;
// dynamic oldPrice;
// int discount;
// String image;
//
// Product({this.id, this.price, this.oldPrice, this.discount, this.image});
//
// Product.fromJson(Map<String, dynamic> json) {
// id = json['id'];
// price = json['price'];
// oldPrice = json['old_price'];
// discount = json['discount'];
// image = json['image'];
// }
//
// Map<String, dynamic> toJson() {
// final Map<String, dynamic> data = new Map<String, dynamic>();
// data['id'] = this.id;
// data['price'] = this.price;
// data['old_price'] = this.oldPrice;
// data['discount'] = this.discount;
// data['image'] = this.image;
// return data;
// }
//
