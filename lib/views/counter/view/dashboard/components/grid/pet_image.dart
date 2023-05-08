import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitest/models/pet.dart';
import 'package:digitest/views/counter/view/dashboard/components/hover_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PetImage extends StatefulWidget {
  const PetImage({Key? key, required this.pet}) : super(key: key);

  final Pet pet;

  @override
  _PetImageState createState() => _PetImageState();
}

class _PetImageState extends State<PetImage> {
  bool displayInfo = false;

  void toggleDisplayInfo() {
    setState(() {
      displayInfo = !displayInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMMM yyyy', 'fr_FR');
    final date = formatter.format(widget.pet.creationDate);

    return GestureDetector(
      onTap: toggleDisplayInfo,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: widget.pet.url,
              fit: BoxFit.cover,
            ),
          ),
          if (displayInfo)
            Positioned(
              top: 10,
              right: 10,
              child: HoverText(text: date),
            ),
          Positioned(
            top: displayInfo ? 40 : 10,
            right: 10,
            child: HoverText(text: widget.pet.category),
          ),
          if (displayInfo && widget.pet.description.isNotEmpty)
            Positioned(
              bottom: 10,
              right: 10,
              left: 10,
              child: Wrap(
                children: [
                  HoverText(text: widget.pet.description),
                ],
              ),
            ),
          if (!displayInfo && widget.pet.description.isNotEmpty)
            const Positioned(
              bottom: 10,
              right: 10,
              child: Icon(
                Icons.info_outline,
                color: Colors.black54,
              ),
            ),
        ],
      ),
    );
  }
}
