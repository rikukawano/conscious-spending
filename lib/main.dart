import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/transactions.dart';
import 'screens/overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Transactions(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Conscious Spending',
        theme: ThemeData(
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline2: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                headline3: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                headline4: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.2, // fontSize * height = text height
                ),
                headline5: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                headline6: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                subtitle1: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.25, // height = 20
                ),
                subtitle2: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                caption: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
                bodyText1: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                button: TextStyle(
                  fontFamily: 'Jaldi',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        home: OverviewScreen(),
      ),
    );
  }
}
