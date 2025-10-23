import 'package:flutter/material.dart';
import 'package:mantra_application/common/style/colors/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      backgroundColor: isDark
          ? const Color(0xFF1E1E1E)
          : Colors.white, // ← GANTI
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MantraColors.primaryColors,
      unselectedItemColor: isDark ? Colors.grey[600] : Colors.grey, // ← GANTI
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: isDark ? Colors.white : Colors.black, // ← TAMBAH
      ),
      unselectedLabelStyle: TextStyle(
        color: isDark ? Colors.grey[600] : Colors.grey, // ← TAMBAH
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
      ],
    );
  }
}
