class AddCartModel{
  bool? status;
  String? message;

  AddCartModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message =json['message'];
  }
}