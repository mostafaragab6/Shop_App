class GetCartModel{
  bool? status;
  Data? data;
  GetCartModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data{

  List<CartItem> cartItems =[];

  Data.fromJson(Map<String,dynamic> json){
    json['cart_items'].forEach((element){
      cartItems.add(CartItem.fromJson(element));
    });
  }
}

class CartItem{

  int? quantity;
  Product? product;

  CartItem.fromJson(Map<String,dynamic> json){
    quantity=json['quantity'];
    product=Product.fromJson(json['product']);
  }

}

class Product{
  int? id;
  int? price;
  int? old_price;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;
  int? discount;

  Product.fromJson(Map<String,dynamic> json){
    id =json['id'];
    price =json['price'];
    old_price =json['old_price'];
    image =json['image'];
    name =json['name'];
    in_favorites =json['in_favorites'];
    in_cart =json['in_cart'];
    discount = json['discount'];
  }
}