import 'package:flutter/material.dart';
import 'package:mantra_application/core/data/model/food.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExploreCard extends StatelessWidget {
  final Food food;
  final VoidCallback? onTap;

  const ExploreCard({super.key, required this.food, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // --- Gambar utama ---
              SizedBox(
                width: double.infinity,
                height: 224,
                child: CachedNetworkImage(
                  imageUrl: food.mainImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error_outline),
                ),
              ),

              // --- Overlay putih berisi teks ---
              Container(
                width: double.infinity,
                color: Colors.white.withOpacity(0.9),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Baris atas: nama dan region
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            food.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          food.region.regionName,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Deskripsi singkat
                    Text(
                      food.shortDescription,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
