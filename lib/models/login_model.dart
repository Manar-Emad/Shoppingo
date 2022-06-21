class LoginModel {
  late final bool status;
  String? message;
  UserData? data;

  LoginModel({required this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    ///الداتا دي لو انا دخلت يوزر غلط هترجعلي ف الباك ب null  ف بقوله لو رجع داتا اطبعلي اللي جوا دا لو مطلعش اطبعلي null
    data = json['data']!= null ? UserData.fromJson(json['data']) : null ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  /// دا كونستراكتور عادي
  UserData({this.name,this.image,this.id,this.email,this.credit,this.phone,this.points,this.token});

  /// دلوقتي هعمل named constructor
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

}