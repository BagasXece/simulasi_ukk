import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/products/view_produk/view_produk.dart';

class SearchBars extends StatelessWidget {
  const SearchBars({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return TextField(
          onChanged: (query) {
            context.read<ProductBloc>().add(SearchProducts(query));
          },
          decoration: InputDecoration(
            hintText: 'Cari produk...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        );
      },
    );
  }
}