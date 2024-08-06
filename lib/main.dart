import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:web_craft/home/componets/bottom_navigation.dart';
import 'package:web_craft/home/model/hive/catagory_hive.dart';
import 'package:web_craft/home/model/hive/product_hive.dart';
import 'package:web_craft/home/model/hive/slider_image_hive.dart';
import 'package:provider/provider.dart';
import 'package:web_craft/home/view_model/home_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(ProductModelHiveAdapter().typeId)) {
    Hive.registerAdapter(ProductModelHiveAdapter());
  }
    if (!Hive.isAdapterRegistered(CategoryModelHiveAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelHiveAdapter());
  }
    if (!Hive.isAdapterRegistered(SliderimageHiveAdapter().typeId)) {
    Hive.registerAdapter(SliderimageHiveAdapter());
  }
    runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNav(),
      ),
    );
  }
}
