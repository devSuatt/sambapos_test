
class Item {
  String name;
  String image;
  String caption;

  Item({required this.name, required this.image, required this.caption});

  factory Item.fromJson(Map<dynamic, dynamic> json) {
    return Item(
      name: json['name'], 
      caption: json['caption'], 
      image: json['image'],
    );
  }  

}