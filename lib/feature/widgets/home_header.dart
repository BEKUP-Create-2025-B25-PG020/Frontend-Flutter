import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mantra_application/common/static/navigation_route.dart'; // TAMBAHKAN

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                SvgPicture.asset('assets/image/appbar-logo.svg', height: 40),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NavigationRoute.settingsRoute.name);
            },
            icon: const Icon(
              Icons.settings,
              color: Color(0xFF7BBF3A),
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
