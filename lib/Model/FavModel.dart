class FavModel
{
    bool? status;
    String? message;

    FavModel.fromJson(Map<String,dynamic> json){
      status =json['status'];
      message=json['message'];
    }
}