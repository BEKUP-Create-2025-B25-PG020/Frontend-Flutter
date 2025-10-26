import 'package:flutter/material.dart';
import 'package:mantra_application/common/static/food_detail_result_state.dart';
import 'package:mantra_application/feature/detail/body_of_detail_screen.dart';
import 'package:mantra_application/feature/provider/food_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final int foodId;

  const DetailScreen({super.key, required this.foodId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // Fetch the detail from provider
      context.read<FoodDetailProvider>().fetchDetailFood(widget.foodId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FoodDetailProvider>(
        builder: (context, provider, _) {
          final state = provider.state;
          if (state is FoodDetailLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FoodDetailErrorState) {
            return Center(child: Text(state.error));
          } else if (state is FoodDetailLoadedState) {
            return BodyOfDetailScreen(food: state.data);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
