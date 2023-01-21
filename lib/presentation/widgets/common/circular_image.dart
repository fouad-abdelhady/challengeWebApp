import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage(
      {Key? key, required this.profileImage, required this.diamention})
      : super(key: key);

  final String profileImage;
  final double diamention;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: diamention,
      width: diamention,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(profileImage), fit: BoxFit.cover),
      ),
    );
  }
}
