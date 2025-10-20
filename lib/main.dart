import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mantra_application/core/data/service/http_service.dart';
import 'package:mantra_application/feature/home/home_screen.dart';
import 'package:mantra_application/feature/provider/featured_food_provider.dart';
import 'package:mantra_application/feature/provider/food_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => HttpService()),
        ChangeNotifierProvider(
          create: (context) =>
              FeaturedFoodProvider(httpService: context.read<HttpService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              FoodProvider(httpService: context.read<HttpService>()),
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
    return const MaterialApp(home: HomeScreen());
  }
}
