import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mantra_application/common/provider/index_nav_provider.dart';
import 'package:mantra_application/common/screen/main_screen.dart';
import 'package:mantra_application/common/static/navigation_route.dart';
import 'package:mantra_application/common/style/theme/mantra_theme.dart';
import 'package:mantra_application/core/data/service/http_service.dart';
import 'package:mantra_application/feature/detail/detail_screen.dart';
import 'package:mantra_application/feature/provider/featured_food_provider.dart';
import 'package:mantra_application/feature/provider/food_detail_provider.dart';
import 'package:mantra_application/feature/provider/food_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        Provider(create: (context) => HttpService()),
        ChangeNotifierProvider(
          create: (context) =>
              FeaturedFoodProvider(httpService: context.read<HttpService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              FoodProvider(httpService: context.read<HttpService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              FoodDetailProvider(httpService: context.read<HttpService>()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MantraTheme.lightTheme,
      darkTheme: MantraTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          foodId: ModalRoute.of(context)?.settings.arguments as int,
        ),
      },
    );
  }
}
