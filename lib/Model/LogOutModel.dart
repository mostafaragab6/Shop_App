class LogOutModel{

  bool? status;
  String? message;
  info? Info;

  LogOutModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    Info=json["data"] != null? info.fromJson(json["data"]):null;
  }
}

class info{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  String? token;

  info.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token=json["token"];
  }
}