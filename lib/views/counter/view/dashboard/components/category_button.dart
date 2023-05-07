import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.category,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  final String category;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final buttonColor =
        isSelected ? const Color(0xFFFCB041) : colorScheme.surface;
    final textColor =
        isSelected ? colorScheme.onPrimary : colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          primary: buttonColor,
          onPrimary: textColor,
        ),
        child: Text(category),
      ),
    );
  }
}
