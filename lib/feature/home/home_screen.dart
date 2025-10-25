import 'package:flutter/material.dart';
import 'package:mantra_application/common/static/food_list_result_state.dart';
import 'package:mantra_application/common/style/colors/colors.dart';
import 'package:mantra_application/feature/detail/detail_screen.dart';
import 'package:mantra_application/feature/provider/food_provider.dart';
import 'package:mantra_application/feature/widgets/featured_food_card.dart';
import 'package:mantra_application/feature/widgets/food_card.dart';
import 'package:provider/provider.dart';
import 'package:mantra_application/feature/provider/featured_food_provider.dart';
import 'package:mantra_application/feature/widgets/home_banner.dart';
import 'package:mantra_application/feature/widgets/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGridView = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeBanner(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 21.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Rekomendasi Makanan\nTradisional',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                            // color: Colors.black87,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),

                    //Rekomendasi list Makanan Tradisional
                    Consumer<FeaturedFoodProvider>(
                      builder: (context, provider, _) {
                        final state = provider.state;
                        if (state is FoodListLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FoodListErrorState) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              state.error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (state is FoodListLoadedState) {
                          return SizedBox(
                            height: 240,
                            child: PageView.builder(
                              controller: PageController(
                                viewportFraction: 0.88,
                              ),
                              itemCount: state.data.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final food = state.data[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 12.0,
                                    left: 12,
                                  ),
                                  child: FeaturedFoodCard(
                                    food: food,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailScreen(foodId: food.id),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    SizedBox.square(dimension: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' List Makanan Tradisional',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                              // color: Colors.black87,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isGridView = !isGridView;
                              });
                            },
                            icon: Icon(
                              isGridView
                                  ? Icons.list_outlined
                                  : Icons.grid_view_outlined,
                              color: MantraColors.primaryColors,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //List makanan tradisional
                    Consumer<FoodProvider>(
                      builder: (context, provider, _) {
                        final state = provider.state;
                        if (state is FoodListLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FoodListErrorState) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              state.error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (state is FoodListLoadedState) {
                          // Conditional Grid or List View
                          if (isGridView) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio: 0.85,
                                    ),
                                itemBuilder: (context, index) {
                                  final food = state.data[index];
                                  return FoodCard(
                                    food: food,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailScreen(foodId: food.id),
                                        ),
                                      );
                                    },
                                    compact: isGridView,
                                  );
                                },
                              ),
                            );
                          } else {
                            // Default List View
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.data.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final food = state.data[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                  ),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: FoodCard(
                                      food: food,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailScreen(foodId: food.id),
                                          ),
                                        );
                                      },
                                      compact: isGridView,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
