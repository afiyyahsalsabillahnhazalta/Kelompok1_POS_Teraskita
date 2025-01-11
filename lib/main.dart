import 'package:flutter/material.dart';
import 'NewOrderModal.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'splash_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(), 
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/NewOrderModal': (context) => NewOrderModal(),
      },
    );
  }
}
