import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scanner/config/config.dart';
import 'package:scanner/main.dart';
import 'package:scanner/utility/app_url.dart';
import 'package:http/http.dart' as http;

class ScannerResult extends StatefulWidget {
  const ScannerResult({
    super.key,
    required this.result,
  });
  final String result;

  @override
  State<ScannerResult> createState() => _ScannerResultState();
}

class _ScannerResultState extends State<ScannerResult> {
  bool loading = false;
  var id = "";
  var name = "";
  var type = "";
  var email = "";
  var phone = "";
  var TodayLogin = "";
  var lastTime = "";
  var msg = "";

  Future<void> _load() async {
    print(widget.result);
    print(widget.result);
    setState(() {
      loading = true;
    });
    var data = {"email": widget.result};
    var request = http.Request('POST', Uri.parse(AppUrl.check));
    request.body = json.encode(data);
    request.headers.addAll(ConfigApp.headers);
    http.StreamedResponse response = await request.send();
    var rsp = await response.stream.bytesToString();
    print(rsp);
    if (response.statusCode == 422) {
      setState(() {
        loading = false;
      });
      ConfigApp.WarningFlushBar("User Doesn not exist.", context);
      goTo(Category(), context);
    }
    if (response.statusCode == 200) {
      var rex = jsonDecode(rsp);
      var res = rex['user'];
      if (mounted) {
        setState(() {
          loading = false;
          msg = rex['message'];
          id = res['id'];
          name = res['name'];
          type = res['type'];
          email = res['email'] ?? "";
          phone = res['phone'];
          TodayLogin = res['todayLogin'];
          lastTime = res['last_timer_login'];
        });
      }
    }
  }

  initState() {
    super.initState();
    if (mounted) {
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: SafeArea(
        child: Center(
          child: (loading)
              ? SpinKitWave(
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 30.0,
                )
              : Container(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Message : " + msg.toUpperCase(),
                        style: ConfigApp.style(normal, black, 16),
                      ),
                      sb(12.0),
                      Divider(),
                      Text(
                        "Login Today  :" + TodayLogin.toString(),
                        style: ConfigApp.style(normal, black, 16),
                      ),
                      sb(12.0),
                      Text(
                        "Name :" + name,
                        style: ConfigApp.style(normal, black, 16),
                      ),
                      sb(12.0),
                      Text(
                        "Email :" + email,
                        style: ConfigApp.style(normal, black, 16),
                      ),
                      sb(12.0),
                      Text(
                        "Last date Login :" +
                            ConfigApp().FlightformatDate(lastTime) +
                            ". " +
                            ConfigApp().formatTime(lastTime),
                        style: ConfigApp.style(normal, black, 16),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
