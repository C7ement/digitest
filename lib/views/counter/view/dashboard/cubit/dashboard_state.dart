part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  const DashboardState({required this.selectedCategories});

  factory DashboardState.initial() {
    return const DashboardState(selectedCategories: {});
  }

  final Set<String> selectedCategories;

  DashboardState copyWith({Set<String>? selectedCategories}) {
    return DashboardState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  List<Object?> get props => [selectedCategories];
}
