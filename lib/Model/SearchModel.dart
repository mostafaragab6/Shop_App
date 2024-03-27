class SearchModel{

  bool? status;
  Data? data;
  SearchModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data{

  List<ProdData>? prodData;

  Data.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      prodData!.add(ProdData.fromJson(element));
    });
  }
}

class ProdData{
  int? id;
  int? price;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? in_cart;
  bool? in_favorites;

  ProdData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price =json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    json['images'].forEach((element){
      images!.add(element);
    });
    in_cart=json['in_cart'];
    in_favorites=json['in_favorites'];
  }
}