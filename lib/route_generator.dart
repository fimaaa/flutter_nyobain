import 'package:flutter/material.dart';
import 'package:flutter_application_1/page_data_insert.dart';
import 'package:flutter_application_1/page_data_list.dart';
import 'package:flutter_application_1/page_data_show.dart';
import 'package:flutter_application_1/page_login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        // case '/login':
        return MaterialPageRoute(
            builder: (_) => const LoginPage(title: "Login Page"));
      case '/data':
        return MaterialPageRoute(
            builder: (_) => const ListDataPage(title: "List Data"));
      case '/insert':
        return MaterialPageRoute(
            builder: (_) => const InsertDataPage(title: "Insert Data Page"));
      case '/data/show':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => DataPage(idData: args));
        }
        return _errorRoute();
      default:
        _errorRoute();
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
