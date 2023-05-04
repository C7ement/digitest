import 'package:digitest/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageCubit extends Cubit<List<String>> {
  final UnsplashRepository _repository;

  ImageCubit(this._repository) : super([]) {
    fetchImages(10);
  }

  Future<void> fetchImages(int count) async {
    Fluttertoast.showToast(
      msg: 'Get images',
    );
    try {
      final images = await _repository.fetchImages(count);
      emit(images);
    } catch (e) {
      print('Failed to fetch images: $e');
      await Fluttertoast.showToast(
        msg: 'Failed to fetch images: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
  }
}
