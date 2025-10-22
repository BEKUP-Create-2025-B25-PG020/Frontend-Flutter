import 'package:flutter/material.dart';
import 'package:mantra_application/common/style/colors/colors.dart';
import 'package:mantra_application/feature/provider/favorite_provider.dart';
import 'package:mantra_application/feature/provider/food_detail_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final int foodId;

  const FavoriteButton({super.key, required this.foodId});

  @override
  Widget build(BuildContext context) {
    return Consumer2<FavoriteProvider, FoodDetailProvider>(
      builder: (context, favoriteProvider, detailProvider, _) {
        final isFav = favoriteProvider.isFavorite(foodId);

        return Material(
          color: MantraColors.primaryColors,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () async {
              try {
                await detailProvider.likeOrUnlikeFood(foodId, isFav);
                await favoriteProvider.toggleFavorite(foodId);
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        );
      },
    );
  }
}
