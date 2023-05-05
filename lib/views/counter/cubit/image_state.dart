part of 'image_cubit.dart';

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

class ImageState {
  const ImageState({required this.pets});

  factory ImageState.initial() {
    return const ImageState(pets: []);
  }
  final List<Pet> pets;

  List<Pet> get sortedPets {
    return [...pets]..sort((a, b) => a.creationDate.compareTo(b.creationDate));
  }
}
