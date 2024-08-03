class Product{
  final int Id;
  final String Name;
  final double Price;

  Product({required this.Id, required this.Name, required this.Price});
  factory Product.fromJson(Map<String,dynamic>json){
    return Product(Id: json["id"], Name: json["name"], Price: json["price"]);
  }
}