import 'package:digitest/repository/repository.dart';
import 'package:digitest/views/counter/cubit/image_cubit.dart';
import 'package:digitest/views/counter/view/dashboard/components/category_button.dart';
import 'package:digitest/views/counter/view/dashboard/components/grid/pet_grid_view.dart';
import 'package:digitest/views/counter/view/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageCubit>(
          create: (_) => ImageCubit(UnsplashRepository()),
        ),
        BlocProvider<DashboardCubit>(create: (_) => DashboardCubit()),
      ],
      child: _DashboardPage(),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DigiPet'),
      ),
      body: Center(
        child: BlocBuilder<ImageCubit, ImageState>(
          builder: (context, state) {
            final pets = state.sortedPets;
            final categories = pets.map((p) => p.category).toSet();
            return BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                final filteredPets = state.selectedCategories.isEmpty
                    ? pets
                    : pets
                        .where(
                          (pet) =>
                              state.selectedCategories.contains(pet.category),
                        )
                        .toList();
                final cartTotal = state.shoppingCart
                    .fold(0, (value, pet) => value + pet.price);
                final cartPetCount = state.shoppingCart.length;

                return Column(
                  children: [
                    Wrap(
                      children: categories
                          .map(
                            (c) => CategoryButton(
                              category: c,
                              onPressed: () => context
                                  .read<DashboardCubit>()
                                  .toggleCategory(c),
                              isSelected: state.selectedCategories.contains(c),
                            ),
                          )
                          .toList(),
                    ),
                    Expanded(child: PetGridView(pets: filteredPets)),
                    const SizedBox(height: 8),
                    Container(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                Text(
                                  cartPetCount == 0
                                      ? ':    Empty cart'
                                      : ':    $cartTotal 🍼',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          if (cartPetCount > 0)
                            OutlinedButton(
                              onPressed: () =>
                                  context.read<DashboardCubit>().checkout(),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                              ),
                              child: const Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
