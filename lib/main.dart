import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/binding/global_binding.dart';
import 'package:pokedex/ui/detail/detail_screen.dart';
import 'package:pokedex/ui/home/home_screen.dart';
import 'package:pokedex/ui/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Infinite Scroll - Lazy Loading',
      theme: ThemeData(
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: "/home", page: () => const HomeScreen()),
        GetPage(name: "/detail", page: () => const DetailScreen()),
        GetPage(name: "/", page: () => const SplashScreen())
      ],
      initialRoute: "/",
      // home: const SplashScreen(),
    );
  }
}