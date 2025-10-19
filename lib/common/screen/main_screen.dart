import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mantra_application/common/provider/index_nav_provider.dart';
import 'package:mantra_application/common/widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<IndexNavProvider>();

    return Scaffold(
      body: IndexedStack(
        index: navProvider.indexBottomNavBar,
        children: const [
          // HomeScreen(),
          // ExploreScreen(),
          // FavoriteScreen()
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: navProvider.indexBottomNavBar,
        onTap: (index) {
          context.read<IndexNavProvider>().setIndextBottomNavBar = index;
        },
      ),
    );
  }
}
