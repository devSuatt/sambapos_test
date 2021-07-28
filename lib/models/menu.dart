class Menu {
  final String key;
  final String description;
  final String orderTag;

  Menu({required this.key, required this.description, required this.orderTag});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      key: json['key'],
      description: json['description'],
      orderTag: json['orderTag'],
    );
  }
}
