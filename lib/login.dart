import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanner/config/config.dart';
import 'package:scanner/generate.dart';
import 'package:scanner/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../utility/app_url.dart';
import 'package:http/http.dart' as http;

class LoginPage extends ConsumerStatefulWidget {
  LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool passwordVisible = false;
  bool loading = false;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.FLOATING,
            title: 'Hey Ninja',
            message:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
            duration: Duration(seconds: 3),
          ).show(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Welcome again,',
                            style: ConfigApp.style(bold, black, 24),
                            // textAlign: TextAlign.center,
                            // style: heading2.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      ' Login to continue',
                      style: ConfigApp.style(normal, black, 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 81, 80, 92),
                          // color: Color.fromARGB(255, 81, 80, 92),
                          // color: white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        height: 50.0,
                        child: TextFormField(
                          controller: _username,
                          style: TextStyle(color: black, fontSize: 16.0),
                          autofocus: false,
                          // validator: validateEmail,
                          // onSaved: (value) => _username = value,
                          decoration: InputDecoration(
                            fillColor: black,
                            hintText: 'Phone Number',
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide.none,
                            // ),
                            border: OutlineInputBorder(
                              // borderSide: BorderSide.none,
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 215, 0),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 81, 80, 92),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        height: 50.0,
                        child: TextFormField(
                          obscureText: !passwordVisible,
                          controller: _password,
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                          ),
                          autofocus: false,
                          validator: (value) =>
                              value!.isEmpty ? "Please Enter Password" : null,
                          // onSaved: (value) => _password = value,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            fillColor: Colors.black12,
                            suffixIcon: IconButton(
                              color: black,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide.none,
                            // ),

                            border: OutlineInputBorder(
                              // borderSide: BorderSide.none,
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 215, 0),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      child: (loading)
                          ? SpinKitWave(
                              color: white,
                              size: 30.0,
                            )
                          : Text(
                              "LOGIN",
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                      onPressed: () {
                        if (_username.text.isEmpty) {
                          ConfigApp.WarningFlushBar(
                              "Username is mandatory.", context);
                        } else if (_password.text.isEmpty) {
                          ConfigApp.WarningFlushBar(
                              "Please Insert Your Password.", context);
                        } else {
                          setState(() {
                            loading = true;
                          });
                          webCall();
                        }
                      },
                      style: mybuttonStyle(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future webCall() async {
    var data = {"email": _username.text, "password": _password.text};
    var request = http.Request('POST', Uri.parse(AppUrl.login));
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
    }
    if (response.statusCode == 200) {
      var rex = jsonDecode(rsp);
      var res = rex['user'];
      var id = res['id'];
      var name = res['name'];
      var type = res['type'];
      var email = res['email'];
      var phone = res['phone'];
      var loginCount = res['LoginCount'] ?? 0;
      var todayLogin = res['todayLogin'] ?? 0;
      var createdAt = res['created_at'];
      var updateAt = res['updated_at'];
      var lastTime = res['last_timer_login'];

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("Id", id.toString());
      await sharedPreferences.setString("name", name);
      await sharedPreferences.setString("phone", phone);
      await sharedPreferences.setString("email", email ?? "");
      await sharedPreferences.setInt("loginCount", int.parse(loginCount));
      await sharedPreferences.setInt("todayLogin", int.parse(todayLogin));
      await sharedPreferences.setString("createdAt", createdAt ?? "");
      await sharedPreferences.setString("updateAt", updateAt ?? "");
      await sharedPreferences.setString("lastTime", lastTime ?? "");
      await sharedPreferences.setString("type", type);
      await sharedPreferences.setString("login", "true");
      if (mounted) {
        await ConfigApp.SuccessSnackBar("Login Successful.", context);
        if (type == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Category()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Generatez()),
          );
        }
      }
    }
  }
}
