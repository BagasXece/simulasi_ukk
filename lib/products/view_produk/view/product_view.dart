import 'package:flutter/material.dart';
import 'package:simulasi_ukk/products/view_produk/view_produk.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBars(),
        const SizedBox(height: 16),
        CategoryFilter(),
        const SizedBox(height: 16),
        Expanded(
          child: ProductsList(),
        ),
      ],
    );
  }
}
