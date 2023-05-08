part of 'image_cubit.dart';

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
