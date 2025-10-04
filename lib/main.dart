import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reacpi_app/Home_Page.dart';
import 'package:flutter_reacpi_app/Provider/favotite_provider.dart';
import 'package:flutter_reacpi_app/Provider/quantity.dart';
import 'package:flutter_reacpi_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ReacpiApp());
}

class ReacpiApp extends StatelessWidget {
  const ReacpiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        //for quantity provider
        ChangeNotifierProvider(create: (_) => QuantityProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}
