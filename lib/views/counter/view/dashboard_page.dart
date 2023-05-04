import 'package:digitest/repository/repository.dart';
import 'package:digitest/views/counter/cubit/image_cubit.dart';
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
        child: BlocBuilder<ImageCubit, List<String>>(
          builder: (context, images) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final url = images[index];
                return Image.network(url, fit: BoxFit.cover);
              },
            );
          },
        ),
      ),
    );
  }
}
