import 'package:bloc/bloc.dart';
import 'package:digitest/models/pet.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  void toggleCategory(String category) {
    if (state.selectedCategories.contains(category)) {
      emit(
        state.copyWith(
          selectedCategories: state.selectedCategories.difference({category}),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedCategories: state.selectedCategories.union({category}),
        ),
      );
    }
  }

  void togglePetInCart(Pet pet) {
    if (state.shoppingCart.contains(pet)) {
      emit(
        state.copyWith(
          shoppingCart: state.shoppingCart.difference({pet}),
        ),
      );
    } else {
      emit(
        state.copyWith(
          shoppingCart: state.shoppingCart.union({pet}),
        ),
      );
    }
  }

  void checkout() {
    final cartPetCount = state.shoppingCart.length;
    final sIfNeeded = state.shoppingCart.length > 1 ? 's' : '';
    emit(state.copyWith(
      shoppingCart: {},
    ));
    Fluttertoast.showToast(
      msg: '$cartPetCount pet$sIfNeeded incoming!',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
