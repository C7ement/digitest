class Pet {
  const Pet({
    required this.description,
    required this.alt_description,
    required this.category,
    required this.url,
    required this.creationDate,
  });

  final String category;
  final String url;
  final DateTime creationDate;
  final String description;
  final String alt_description;

  //Dummy price generated from url
  int get price {
    final hash = url.hashCode;
    final price = (hash % 90) + 10;
    return price;
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      category: json['category'] as String,
      description: json['description'] as String,
      alt_description: json['alt_description'] as String,
      url: json['url'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'alt_description': alt_description,
      'url': url,
      'creationDate': creationDate.toIso8601String(),
    };
  }
}
