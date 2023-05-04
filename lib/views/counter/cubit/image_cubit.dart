import 'package:digitest/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'image_state.dart';

class ImageCubit extends HydratedCubit<ImageState> {
  final UnsplashRepository _repository;

  ImageCubit(this._repository) : super(ImageState.initial()) {
    if (state.pets.isEmpty) {
      fetchPuppies(10);
    }
  }

  Future<void> fetchPuppies(int count) async {
    try {
      final keywords = [
        'puppy',
        'kitten',
        'rabbit',
        'hamster',
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

  @override
  ImageState? fromJson(Map<String, dynamic> json) {
    final pets = (json['pets'] as List<dynamic>)
        .map((pet) => Pet.fromJson(pet as Map<String, dynamic>))
        .toList();
    return ImageState(pets: pets);
  }

  @override
  Map<String, dynamic>? toJson(ImageState state) {
    final pets = state.pets.map((pet) => pet.toJson()).toList();
    return {'pets': pets};
  }
}
