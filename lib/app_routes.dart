import 'package:flutter/material.dart';
import 'package:simulasi_ukk/create_product/view/create_product_page.dart';
import 'package:simulasi_ukk/create_user/view/create_user_page.dart';
import 'package:simulasi_ukk/home/view/home_page.dart';
import 'package:simulasi_ukk/login/view/login_page.dart';
import 'package:simulasi_ukk/produk/view/product_page.dart';
import 'package:simulasi_ukk/splash/view/splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String createUser = '/create-user';
  static const String produk = '/produk';
  static const String login = '/login';
  static const String addProduct = '/add-product';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (_) => const SplashPage(),
      login: (_) => const LoginPage(),
      home: (_) => const HomePage(),
      createUser: (_) => const CreateUserPage(),
      produk: (_) => const ProductsPage(),
      addProduct: (_) => const CreateProductPage(),
    };
  }

static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Navigator.of(context).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  // static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
  //   BuildContext context,
  //   String routeName, {
  //   bool Function(Route<dynamic>)? predicate,
  //   Object? arguments,
  // }) {
  //   return Navigator.of(context).pushNamedAndRemoveUntil<T>(
  //     routeName,
  //     predicate ?? (route) => false,
  //     arguments: arguments,
  //   );
  // }

  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).pop<T>(result);
  }

  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  // Get current route name - FIXED VERSION
  static String? currentRoute(BuildContext context) {
    final route = ModalRoute.of(context);
    return route?.settings.name;
  }

  // Debug method untuk print current route
  // static void printCurrentRoute(BuildContext context) {
  //   final currentRoute = ModalRoute.of(context)?.settings.name;
  // }
}