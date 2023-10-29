import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var normal = FontWeight.normal;
var bold = FontWeight.bold;
var w100 = FontWeight.w100;
var w200 = FontWeight.w200;
var w300 = FontWeight.w300;
var w400 = FontWeight.w400;
var w500 = FontWeight.w500;
var w600 = FontWeight.w600;
var w700 = FontWeight.w700;
var w800 = FontWeight.w800;
var w900 = FontWeight.w900;
var black = Colors.black;
var black12 = Colors.black12;
var black38 = Colors.black38;
var black54 = Colors.black54;
var black87 = Colors.black87;
var white = Colors.white;
var white12 = Colors.white12;
var white54 = Colors.white54;
var white70 = Colors.white70;
var gold = Color.fromARGB(255, 255, 215, 0);
loader(size, color) {
  return Container(
    height: size,
    width: size,
    child: CircularProgressIndicator(
      color: color,
      strokeWidth: 2,
    ),
  );
}

normalstyle() {
  return ConfigApp.style(normal, black, 14);
}

smallstyle() {
  return ConfigApp.style(normal, black, 11);
}

BigInt() {
  return ConfigApp.style(normal, black, 18);
}

myOutlineStyle() {
  return OutlinedButton.styleFrom(
    fixedSize: Size(500, 45),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    side: BorderSide(
      color: Color.fromARGB(255, 166, 141, 0),
    ),
  );
}

mqheight(context) {
  return MediaQuery.of(context).size.height;
}

mqwidth(context) {
  return MediaQuery.of(context).size.height;
}

class ConfigApp {
  static const String appName = 'Ogasaairtime';

  static String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  static svg(assets, height, color) {
    return SvgPicture.asset(
      assets,
      height: height.toDouble(),
      color: (color == null) ? null : color,
    );
  }

  Column address() {
    return Column(
      children: [
        Text(
          "Suite 109, ALBA Plaza (Panda Supermarket) opposite Busy Mart Plaza." +
              "Jabi, Abuja",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Icon(
              Icons.email,
            ),
            SelectableText(
              "ogasaairtime@gmail.com",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Icon(
              Icons.language,
            ),
            SelectableText(
              "www.ogasaairtime@gmail.com",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  D(date) {
    if (date is String) {
      date = DateTime.parse(date);
    }
    var dy = DateFormat('d').format(date);
    String formattedTime = dy.toString();

    return (formattedTime);
  }

  D2(date) {
    if (date is String) {
      date = DateTime.parse(date);
    }
    var dy = DateFormat('E d').format(date);
    String formattedTime = dy.toString();

    return (formattedTime);
  }

  M(date) {
    if (date is String) {
      date = DateTime.parse(date);
    }
    var month = DateFormat('LLL').format(date);
    String formattedTime = month;

    return (formattedTime);
  }

  Y(date) {
    if (date is String) {
      date = DateTime.parse(date);
    }
    var year = DateFormat('y').format(date);
    String formattedTime = year;

    return (formattedTime);
  }

  H(date) {
    if (date is String) {
      date = DateTime.parse(date);
    }
    var year = DateFormat('HH').format(date);
    String formattedTime = year;

    return (formattedTime);
  }

  mm(date) {
    if (date is String) {
      date = DateTime.parse(date);
    }
    var year = DateFormat('mm ').format(date);
    String formattedTime = year;

    return (formattedTime);
  }

  AP(date) {
    if (date is String) {
      date = DateTime.parse(date);
    }
    var year = DateFormat('a').format(date);
    String formattedTime = year;

    return (formattedTime);
  }

  formatDate(date) {
    return ConfigApp().D(date) +
        " " +
        ConfigApp().M(date) +
        " " +
        ConfigApp().Y(date);
  }

  FlightformatDate(date) {
    return ConfigApp().D2(date) + " " + ConfigApp().M(date);
  }

  FlightformatTime(date) {
    return ConfigApp().H(date) +
        ":" +
        ConfigApp().mm(date) +
        ConfigApp().AP(date);
  }

  formatTime(date) {
    if (date is String) {
      date = DateTime.parse(date);
    }
    return DateFormat('hh:mm a').format(date);
  }

  static style(fontWeight, Color color, size) {
    return GoogleFonts.inter(
        textStyle: TextStyle(
            fontWeight: fontWeight, fontSize: size.toDouble(), color: color));
  }

  fm(date) {
    //var formatter = new DateFormat('dd-MM-yyyy');
    var month = DateFormat('LLL').format(date);
    var dy = DateFormat('d').format(date);
    var year = DateFormat('y').format(date);
    String formattedTime = dy.toString() + " " + month + " " + year.toString();

    return (formattedTime);
  }

  // numberformat(num) {
  //   if (num == null) {
  //     return '00';
  //   }
  //   return NumberFormat.currency(name: 'NGN').format(num); // EURO123,456.00
  // }

  numformat(number) {
    if (number is String) {
      return "₦ " + number;
    }
    return NumberFormat.currency(name: '₦ ').format(number).toString();
  }

  format(number) {
    return NumberFormat.currency(name: '').format(number).toString();
  }

  static var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + ConfigApp.token.toString(),
  };

  static SharedPreferences? sharedPreferences;

  // static final String? userId = ConfigApp.sharedPreferences?.getString('userId');
  static final String? token = ConfigApp.sharedPreferences?.getString('token');
  // static final String? username = ConfigApp.sharedPreferences?.getString('username');
  static final String? phone = ConfigApp.sharedPreferences!.getString('phone');
  static final String? fname = ConfigApp.sharedPreferences!.getString('fname');
  static final String? bvn = ConfigApp.sharedPreferences!.getString('bvn');
  static final String? nin = ConfigApp.sharedPreferences!.getString('nin');
  static final String? lname = ConfigApp.sharedPreferences!.getString('lname');
  static final String? email = ConfigApp.sharedPreferences!.getString('email');
  static final String? regDate =
      ConfigApp.sharedPreferences!.getString('regDate');
  static final String? designation =
      ConfigApp.sharedPreferences!.getString('designation');
  static final String? Tcode = ConfigApp.sharedPreferences!.getString('Tcode');
  static final String? plan = ConfigApp.sharedPreferences!.getString('plan');
  static final String? wallet =
      ConfigApp.sharedPreferences!.getString('wallet');
  static final String? password =
      ConfigApp.sharedPreferences!.getString('password');
  static final int? FlightAdultCount =
      ConfigApp.sharedPreferences!.getInt('adultCount');
  static final String? totalFlightPerson =
      ConfigApp.sharedPreferences!.getString('totalFlightPerson');
  static final String? PassengerDetail =
      ConfigApp.sharedPreferences!.getString("PassengerDetails");
  static final String? login = ConfigApp.sharedPreferences?.getString("login");

  var gColor = Color(0xffF5F5F5);
  var gtColor = Color(0xff788190);
  goTo(Widget page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  static SuccessSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    ));
  }

  static FailedSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.info_outlined,
            color: white,
            size: 16,
          ),
          Text(
            message,
            style: ConfigApp.style(normal, white, 15),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      elevation: 14,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(12),
    ));
  }

  static WarningSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.yellow[800],
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    ));
  }

  static WarningFlushBar(String message, BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Color.fromARGB(255, 247, 142, 135),
      titleColor: black,
      title: 'Warning',
      message: message,
      duration: Duration(seconds: 3),
    ).show(context);

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(message),
    //   backgroundColor: Colors.yellow[800],
    //   elevation: 10,
    //   behavior: SnackBarBehavior.floating,
    //   margin: EdgeInsets.all(5),
    // ));
  }

  random(min, max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }

  goToReplacement(Widget page, BuildContext context) {
    Navigator.of(context).pushReplacement(_createRoute(page));
  }

  Route _createRoute(nav) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nav,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }

  void show(context, Widget widget) {
    // showDialog(context: context, builder: (context) => Advisory());
    showDialog(context: context, builder: (context) => widget);
  }

  todayDate(date) {
    var formatter = new DateFormat('dd-MM-yyyy');
    // String formattedTime = DateFormat('kk:mm:a').format(date);
    String formattedDate = formatter.format(date);
    return (formattedDate);
  }

  changeGood(val) {
    if (val == '1') {
      return 'Done';
    }
    return 'N/A';
  }

  static colField(
      text1, TextEditingController _controller, maxLine, Textcolor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Textcolor,
              ),
            )),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _controller,
          maxLines: maxLine,
          decoration: InputDecoration(
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                //borderSide: const BorderSide(),
              ),
              hintStyle: TextStyle(
                  color: Color(0Xff969799), fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: Color(0XFFf5f5f5),
              hintText: text1),
        ),
      ],
    );
  }

  Row ConfirmationRow(text, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        Flexible(
          child: Text(
            value!,
            textAlign: TextAlign.right,
            overflow: TextOverflow.visible,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}

goTo(Widget page, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ),
  );
}

goToReplacement(Widget page, BuildContext context) {
  Navigator.of(context).pushReplacement(_createRoute(page));
}

Route _createRoute(nav) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nav,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}

sb(h) {
  return SizedBox(
    height: h,
  );
}

List<String> checkMTN = [
  "0703",
  "0706",
  "0803",
  "0806",
  "0810",
  "0813",
  "0814",
  "0816",
  "0702",
  "0903",
  "0906",
  "0916",
  "0704",
];
List<String> checkAIRTEL = [
  "0701",
  "0708",
  "0802",
  "0912",
  "0808",
  "0812",
  "0901",
  "0902",
  "0904",
];
List<String> checkGLO = [
  "0705",
  "0805",
  "0915",
  "0807",
  "0815",
  "0905",
];
List<String> checkMOBILE = [
  "0809",
  "0817",
  "0818",
  "0909",
  "0908",
];

class Mybutton extends StatelessWidget {
  const Mybutton({
    super.key,
    this.text = "demo",
    this.bgColor = Colors.white,
    this.txtColor = Colors.black,
    required this.onPressed,
  });

  final String text;
  final Color bgColor;
  final Color txtColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text(
          text,
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: txtColor,
              fontSize: 14.0,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          fixedSize: Size(500, 45),
        ),
        onPressed: onPressed);
  }
}

mybuttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    padding: const EdgeInsets.all(8.0),
    fixedSize: Size(500, 50),
  );
}
