import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mantra_application/common/static/explore_list_result_state.dart';
import 'package:mantra_application/feature/provider/explore_list_provider.dart';
import 'package:mantra_application/feature/widgets/explore_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:mantra_application/common/static/navigation_route.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExploreListProvider>().fetchExploreList();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    // reset timer setiap kali user mengetik
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      // hanya update query setelah user berhenti mengetik 0.5 detik
      setState(() {
        query = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: SvgPicture.asset('assets/image/appbar-logo.svg', height: 40),
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Consumer<ExploreListProvider>(
        builder: (context, provider, child) {
          final state = provider.resultState;

          if (state is ExploreListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExploreListLoadedState) {
            final allFoods = state.data;

            // Filter hasil pencarian
            final filteredFoods = allFoods
                .where(
                  (food) =>
                      food.name.toLowerCase().contains(query.toLowerCase()) ||
                      food.region.regionName.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();

            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(12),
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Cari makanan tradisional...',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.grey[600] : Colors.grey,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: isDark ? Colors.grey[600] : Colors.grey,
                        ),
                        filled: true,
                        fillColor: isDark
                            ? const Color(0xFF1E1E1E)
                            : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: filteredFoods.isEmpty
                      ? Center(
                          child: Text(
                            "Tidak ada makanan ditemukan.",
                            style: TextStyle(
                              fontSize: 16,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: filteredFoods.length,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) => ExploreCard(
                            food: filteredFoods[index],
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NavigationRoute.detailRoute.name,
                                arguments: filteredFoods[index].id,
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          } else if (state is ExploreListErrorState) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
