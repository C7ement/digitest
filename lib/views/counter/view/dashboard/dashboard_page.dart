import 'package:digitest/repository/repository.dart';
import 'package:digitest/views/counter/cubit/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

class HoverText extends StatelessWidget {
  const HoverText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
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
          },
        ),
      ),
    );
  }
}
