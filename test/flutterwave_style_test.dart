// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutterwave_standard/flutterwave.dart';

// main() {
//   group("Flutterwave Style should", () {

//     final buttonTextStyle = TextStyle(
//       color: Colors.deepOrangeAccent,
//       fontSize: 16,
//     );

//     var style = FlutterwaveStyle(
//       appBarText: "My Standard Blue",
//       buttonColor: Color(0xffd0ebff),
//       buttonTextStyle: buttonTextStyle,
//       appBarColor: Color(0xff8fa33b),
//       dialogCancelTextStyle: TextStyle(
//         color: Colors.brown,
//         fontSize: 18,
//       ),
//       dialogContinueTextStyle: TextStyle(
//         color: Colors.purpleAccent,
//         fontSize: 18,
//       ),
//       mainBackgroundColor: Colors.indigo,
//       mainTextStyle: TextStyle(
//           color: Colors.indigo,
//           fontSize: 19,
//           letterSpacing: 2
//       ),
//       dialogBackgroundColor: Colors.greenAccent,
//       appBarIcon: Icon(Icons.message, color: Colors.purple),
//       buttonText: "Pay",
//       appBarTitleTextStyle: TextStyle(
//         color: Colors.purpleAccent,
//         fontSize: 18,
//       ),
//     );

//     test("return correct style properties", () {
//       expect(Colors.greenAccent, style.getDialogBackgroundColor());
//       expect("My Standard Blue", style.getAppBarText());
//       expect(Colors.indigo, style.getMainBackgroundColor());
//       expect("Pay", style.getButtonText());
//       expect(buttonTextStyle, style.getButtonTextStyle());
//     });

//     test("return default style properties if style properties are not set", () {
//       style = FlutterwaveStyle();
//       expect(Colors.white, style.getDialogBackgroundColor());
//       expect("Flutterwave", style.getAppBarText());
//       expect(Colors.white, style.getMainBackgroundColor());
//       expect("Make Payment", style.getButtonText());
//       expect(Color(0xFFfff1d0), style.getAppBarColor());
//     });

//   });

// }
