import 'package:digitest/models/pet.dart';
import 'package:digitest/views/counter/view/dashboard/components/grid/pet_image.dart';
import 'package:digitest/views/counter/view/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetGridItem extends StatelessWidget {
  const PetGridItem({Key? key, required this.pet}) : super(key: key);

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final isInCart = state.shoppingCart.contains(pet);

        return Flexible(
          child: Column(
            children: [
              PetImage(pet: pet),
              Container(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text(
                          '${pet.price} 🍼',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            context.read<DashboardCubit>().togglePetInCart(pet),
                        child: isInCart
                            ? const Icon(
                                Icons.remove_shopping_cart,
                                color: Colors.redAccent,
                              )
                            : const Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
