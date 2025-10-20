import 'package:flutter/material.dart';
import 'package:mantra_application/common/static/food_detail_result_state.dart';
import 'package:mantra_application/core/data/model/food_detail.dart';
import 'package:mantra_application/feature/provider/food_detail_provider.dart';
import 'package:mantra_application/feature/widgets/favorite_button.dart';
import 'package:provider/provider.dart';

class BodyOfDetailScreen extends StatelessWidget {
  final FoodDetail food;
  const BodyOfDetailScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final facts = food.interestingFacts
        .split(RegExp(r'\.\s*'))
        .where((f) => f.trim().isNotEmpty)
        .toList();

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      food.mainImageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 60,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7BBF3A),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: SizedBox(
                height: 40,
                child: Stack(
                  alignment: Alignment.centerRight,
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        food.name,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF7BBF3A),
                        ),
                      ),
                    ),
                    Positioned(right: 4, top: 12, child: FavoriteButton()),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(Icons.pin_drop_outlined, size: 18),
                        SizedBox.square(dimension: 4),
                        Text(
                          '${food.region.regionName}, ${food.region.island}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  food.longDescription,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sejarah',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF7BBF3A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      food.foodHistory,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fakta Menarik',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF7BBF3A),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Bullet list items
                    ...facts.map(
                      (text) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(fontSize: 18, height: 1.4),
                            ),
                            Expanded(
                              child: Text(
                                '${text.trim()}.', // add period back
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  height: 1.4,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<FoodDetailProvider>(
              builder: (context, provider, _) {
                final state = provider.state;

                if (state is FoodDetailLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FoodDetailErrorState) {
                  return Center(child: Text(state.error));
                } else if (state is FoodDetailLoadedState) {
                  // Calculate total pages based on 4 images per page
                  final totalPages = (food.galleries.length / 4).ceil();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'Galeri Foto',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7BBF3A),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 360,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.9),
                          physics: const BouncingScrollPhysics(),
                          itemCount: totalPages,
                          itemBuilder: (context, pageIndex) {
                            final startIndex = pageIndex * 4;
                            final endIndex =
                                (startIndex + 4 <= food.galleries.length)
                                ? startIndex + 4
                                : food.galleries.length;
                            final pageItems = food.galleries.sublist(
                              startIndex,
                              endIndex,
                            );
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GridView.builder(
                                itemCount: pageItems.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                itemBuilder: (context, index) {
                                  final gallery = pageItems[index];
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      gallery.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
