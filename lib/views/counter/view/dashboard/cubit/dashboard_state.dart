part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  const DashboardState({
    required this.selectedCategories,
    required this.shoppingCart,
  });

  factory DashboardState.initial() {
    return const DashboardState(selectedCategories: {}, shoppingCart: {});
  }

  final Set<String> selectedCategories;
  final Set<Pet> shoppingCart;

  DashboardState copyWith({
    Set<String>? selectedCategories,
    Set<Pet>? shoppingCart,
  }) {
    return DashboardState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      shoppingCart: shoppingCart ?? this.shoppingCart,
    );
  }

  @override
  List<Object?> get props => [
        selectedCategories,
        shoppingCart,
      ];
}
