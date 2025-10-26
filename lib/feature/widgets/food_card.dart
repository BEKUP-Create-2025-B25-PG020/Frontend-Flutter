import 'package:flutter/material.dart';
import 'package:mantra_application/core/data/model/food.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final Function() onTap;
  final bool compact;

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: compact ? 160 : 350,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white, // ← GANTI
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                food.mainImageUrl,
                width: double.infinity,
                height: compact ? 100 : 130,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: compact ? 100 : 130,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: compact ? 12 : 14,
                      color: isDark ? Colors.white : Colors.black, // ← GANTI
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    food.region.regionName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: compact ? 11 : 12,
                      color: isDark
                          ? Colors.white70
                          : Colors.black87, // ← GANTI
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    food.shortDescription,
                    maxLines: compact ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: compact ? 11 : 12,
                      color: isDark
                          ? Colors.white60
                          : Colors.black87, // ← GANTI
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
