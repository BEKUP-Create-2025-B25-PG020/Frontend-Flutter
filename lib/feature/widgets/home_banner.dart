import 'package:flutter/material.dart';
import 'package:mantra_application/common/style/colors/colors.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // Background image
            Image.asset(
              'assets/image/banner-1.png',
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            // Gradient overlay
            Container(
              height: 240,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    MantraColors.primaryColors.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),

            // Text overlay
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ayo mulai eksplor makanan tradisional di Mantra!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
