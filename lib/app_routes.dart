import 'package:flutter/material.dart';
import 'package:simulasi_ukk/customers/add_customer/view/add_customer_page.dart';
import 'package:simulasi_ukk/products/create_product/create_product.dart';
import 'package:simulasi_ukk/users/create_user/create_user.dart';
import 'package:simulasi_ukk/customers/view_customer/view_customer.dart';
import 'package:simulasi_ukk/home/home.dart';
import 'package:simulasi_ukk/users/login/login.dart';
import 'package:simulasi_ukk/products/view_produk/view_produk.dart';
import 'package:simulasi_ukk/splash/splash.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String createUser = '/create-user';
  static const String produk = '/produk';
  static const String login = '/login';
  static const String addProduct = '/add-product';
  static const String customer = '/pelanggan';
  static const String addCustomer = '/add-customer';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (_) => const SplashPage(),
      login: (_) => const LoginPage(),
      home: (_) => const HomePage(),
      createUser: (_) => const CreateUserPage(),
      produk: (_) => const ProductsPage(),
      addProduct: (_) => const CreateProductPage(),
      customer: (_) => const CustomerPage(),
      addCustomer: (_) => const AddCustomerPage()
    };
  }


  // static Route<dynamic> generateRoute(RouteSettings setting) {
  //   switch (setting.name) {
  //     case splash:
  //       return MaterialPageRoute(builder: (_) => const SplashPage());
  //     case login:
  //       return MaterialPageRoute(builder: (_) => const LoginPage());
  //     case home:
  //       return MaterialPageRoute(builder: (_) => const HomePage());
  //     case createUser:
  //       return MaterialPageRoute(builder: (_) => const CreateUserPage());
  //     case produk:
  //       return MaterialPageRoute(builder: (_) => const ProductsPage());
  //     case addProduct:
  //       return MaterialPageRoute(builder: (_) => const CreateProductPage());
  //     case customer:
  //       return MaterialPageRoute(builder: (_) => const CustomerPage()); 
  //     default:
  //     return MaterialPageRoute(builder: (_) => const HomePage());
  //   }
  // }

  static Future<T?> navigationWithSplash<T extends Object?>(BuildContext context, String targetRoute) {
    return Navigator.pushNamed(context, AppRoutes.splash, arguments: targetRoute);
  }

  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
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
