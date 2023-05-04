import 'package:digitest/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final UnsplashRepository _repository;

  ImageCubit(this._repository) : super(ImageState.initial()) {
    fetchPuppies(10);
  }

  Future<void> fetchPuppies(int count) async {
    try {
      final keywords = [
        'puppy',
        'kitten',
        'rabbit',
        'hamster',
        'ferret',
        'hedgehog',
        'duckling'
      ];
      final futures = keywords.map(
        (keyword) => _repository.fetchPets(count: count, query: keyword),
      );
      final results = await Future.wait(futures);
      final pets = results.expand((list) => list).toList();
      emit(ImageState(pets: pets));
    } catch (e) {
      print('Failed to fetch puppies: $e');
      await Fluttertoast.showToast(
        msg: 'Failed to fetch puppies: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
  }
}
