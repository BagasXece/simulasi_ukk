import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:simulasi_ukk/app_routes.dart';
import 'package:simulasi_ukk/products/view_produk/view_produk.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              AppRoutes.pushNamed(context, AppRoutes.addProduct);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) =>
              ProductBloc(productRepository: context.read<ProductRepository>())
                ..add(const LoadProducts())
                ..add(const LoadCategories()),
          child: const ProductsView(),
        ),
      ),
    );
  }
}
