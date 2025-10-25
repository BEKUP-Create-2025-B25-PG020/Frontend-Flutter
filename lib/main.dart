import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mantra_application/common/provider/index_nav_provider.dart';
import 'package:mantra_application/common/provider/theme_provider.dart';
import 'package:mantra_application/common/screen/main_screen.dart';
import 'package:mantra_application/common/static/navigation_route.dart';
import 'package:mantra_application/common/style/theme/mantra_theme.dart';
import 'package:mantra_application/core/data/service/http_service.dart';
import 'package:mantra_application/feature/detail/detail_screen.dart';
import 'package:mantra_application/feature/onboarding/onboarding_screen.dart';
import 'package:mantra_application/feature/settings/screen/about_screen.dart';
import 'package:mantra_application/feature/settings/screen/settings_screen.dart';
import 'package:mantra_application/feature/provider/explore_list_provider.dart';
import 'package:mantra_application/feature/provider/favorite_provider.dart';
import 'package:mantra_application/feature/provider/featured_food_provider.dart';
import 'package:mantra_application/feature/provider/food_detail_provider.dart';
import 'package:mantra_application/feature/provider/food_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        Provider(create: (context) => HttpService()),
        ChangeNotifierProvider(
          lazy: true,
          create: (context) =>
              FeaturedFoodProvider(httpService: context.read<HttpService>()),
        ),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(
          lazy: true,
          create: (context) =>
              FoodProvider(httpService: context.read<HttpService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              FoodDetailProvider(httpService: context.read<HttpService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => ExploreListProvider(context.read<HttpService>()),
        ),
      ],
      child: MainApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool hasSeenOnboarding;

  const MainApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MantraTheme.lightTheme,
          darkTheme: MantraTheme.darkTheme,
          themeMode: themeProvider.themeMode,

          home: hasSeenOnboarding
              ? const MainScreen()
              : const OnboardingScreen(),

          routes: {
            NavigationRoute.homeroute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
              foodId: ModalRoute.of(context)?.settings.arguments as int,
            ),
            NavigationRoute.settingsRoute.name: (context) =>
                const SettingsScreen(),
            NavigationRoute.aboutRoute.name: (context) => const AboutScreen(),
          },
        );
      },
    );
  }
}
