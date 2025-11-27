import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:simulasi_ukk/produk/produk.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => ProductBloc(
            productRepository: context.read<ProductRepository>(),
          )..add(const LoadProducts())
            ..add(const LoadCategories()),
          child: const ProductsView(),
        ),
      ),
    );
  }
}