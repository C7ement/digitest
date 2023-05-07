import 'package:digitest/views/counter/cubit/image_cubit.dart';
import 'package:digitest/views/counter/view/dashboard/components/hover_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PetGridView extends StatelessWidget {
  const PetGridView({Key? key, required this.pets}) : super(key: key);

  final List<Pet> pets;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];
        final formatter = DateFormat('dd MMMM yyyy', 'fr_FR');
        final date = formatter.format(pet.creationDate);
        return Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(pet.url, fit: BoxFit.cover),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: HoverText(text: date),
            ),
            Positioned(
              top: 40,
              right: 10,
              child: HoverText(text: pet.category),
            ),
            Positioned(
              top: 70,
              right: 10,
              child: HoverText(text: pet.description),
            ),
          ],
        );
      },
    );
  }
}
