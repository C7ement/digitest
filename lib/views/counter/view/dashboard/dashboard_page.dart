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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Bottom row text',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
