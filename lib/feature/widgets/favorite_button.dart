import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF7BBF3A),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.favorite_border, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}
