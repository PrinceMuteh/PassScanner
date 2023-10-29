import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner/config/config.dart';
import 'package:scanner/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Generatez extends StatefulWidget {
  const Generatez({super.key});
  @override
  State<Generatez> createState() => _GeneratezState();
}

class _GeneratezState extends State<Generatez> {
  var code = "";
  var name = "";
  Future<void> _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      code = prefs.getString("phone")!;
      name = prefs.getString("name")!;
    });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: ConfigApp.style(normal, black, 20),
              ),
              sb(24.0),
              QrImageView(
                data: code,
                version: QrVersions.auto,
                size: 300.0,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
