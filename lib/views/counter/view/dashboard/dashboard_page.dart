import 'package:digitest/repository/repository.dart';
import 'package:digitest/views/counter/cubit/image_cubit.dart';
import 'package:digitest/views/counter/view/dashboard/components/pet_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageCubit>(
      create: (_) => ImageCubit(UnsplashRepository()),
      child: _DashboardPage(),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: BlocBuilder<ImageCubit, ImageState>(
          builder: (context, state) {
            final pets = state.sortedPets;
            final categories = pets.map((p) => p.category).toSet();
            return Column(
              children: [
                Wrap(
                  children: categories
                      .map(
                        (c) => Padding(
                          padding: const EdgeInsets.all(8),
                          child:
                              OutlinedButton(onPressed: null, child: Text(c)),
                        ),
                      )
                      .toList(),
                ),
                Expanded(child: PetGridView(pets: pets))
              ],
            );
          },
        ),
      ),
    );
  }
}
