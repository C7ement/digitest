import 'package:digitest/models/pet.dart';
import 'package:digitest/views/counter/view/dashboard/components/grid/pet_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PetGridView extends StatelessWidget {
  const PetGridView({Key? key, required this.pets}) : super(key: key);

  final List<Pet> pets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MasonryGridView.count(
        itemCount: pets.length,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return PetGridItem(pet: pet);
        },
      ),
    );
  }
}
