import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:simulasi_ukk/create_product/create_product.dart';
import 'package:simulasi_ukk/create_product/view/create_product_form.dart';

class CreateProductPage extends StatelessWidget {
  const CreateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => CreateProductBloc(
            productRepository: context.read<ProductRepository>(),
          ),
          child: const CreateProductForm(),
        ),
      ),
    );
  }
}
