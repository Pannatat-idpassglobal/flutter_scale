import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/drawermenu/about/about_screen.dart';
import 'package:flutter_scale/screens/drawermenu/contact/contact_screen.dart';
import 'package:flutter_scale/screens/drawermenu/info/info_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/screens/welcome/welcome_screen.dart';

//App router Class
class AppRouter {
  //Router Map Key
  static const String welcome = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String contact = '/contact';
  static const String info = '/info';
  static const String about = '/about';

  static Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginScreen(),
    dashboard: (context) => const DashboardScreen(),
    about: (context) => const AboutScreen(),
    info: (context) => const InfoScreen(),
    contact: (context) => const ContactScreen(),

    //bottom nav menu
    
  };
}
