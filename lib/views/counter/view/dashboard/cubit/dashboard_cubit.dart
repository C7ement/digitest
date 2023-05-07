import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
}
