part of 'dashboard_cubit.dart';

class DashboardState {
  const DashboardState({required this.selectedCategory});

  factory DashboardState.initial() {
    return const DashboardState(selectedCategory: null);
  }

  final int? selectedCategory;
}
