import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanner/config/config.dart';
import 'package:scanner/generate.dart';
import 'package:scanner/login.dart';
import 'package:scanner/scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LoginScanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Category(),
    );
  }
}

class Category extends StatefulWidget {
  const Category({super.key});
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Future<void> _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.setString("login", "false");

    if (await prefs.getString("login") != "true") {
      goToReplacement(LoginPage(), context);
    } else {
      if (await prefs.getString("type") == "User") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Generatez()),
        );
      }
    }
  }

  initState() {
    super.initState();
    if (mounted) {
      _load();
    }
  }

  Future<void> _logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("login", "false");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: Text(
          "Login Scanner",
          style: ConfigApp.style(normal, white, 14),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              size: 25,
              color: white,
            ),
            tooltip: 'notification Icon',
            onPressed: () {
              _logout();
              goToReplacement(Category(), context);
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'User Type : Admin',
                style: ConfigApp.style(bold, black, 20),
              ),
              sb(24.0),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.barcode_reader,
                  color: Colors.white,
                  size: 30.0,
                ),
                label: Text(
                  'Scanner',
                  style: ConfigApp.style(normal, white, 14),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Scanner()),
                  );
                },
                style: mybuttonStyle(),
              ),
              sb(24.0),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 30.0,
                ),
                label: Text(
                  'Generate Code',
                  style: ConfigApp.style(normal, white, 14),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Generatez()),
                  );
                },
                style: mybuttonStyle(),
              )
            ],
          ),
        ),
      )),
    );
  }
}
