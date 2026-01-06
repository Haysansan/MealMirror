import 'package:flutter/material.dart';

class PetAvatar extends StatelessWidget {
  const PetAvatar({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    // Currently unused; keep as a harmless placeholder.
    return SizedBox.square(dimension: size);
  }
}
