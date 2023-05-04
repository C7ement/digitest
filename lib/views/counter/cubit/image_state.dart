part of 'image_cubit.dart';

class Pet {
  final String category;
  final String url;
  final DateTime creationDate;

  const Pet({
    required this.category,
    required this.url,
    required this.creationDate,
  });
}

class ImageState {
  final List<Pet> pets;

  List<Pet> get sortedPets {
    return [...pets]..sort((a, b) => a.creationDate.compareTo(b.creationDate));
  }

  const ImageState({required this.pets});

  factory ImageState.initial() {
    return ImageState(pets: []);
  }
}
