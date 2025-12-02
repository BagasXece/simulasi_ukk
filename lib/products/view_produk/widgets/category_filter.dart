import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/products/view_produk/view_produk.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.categories.isEmpty) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CategoryChip(
                category: null,
                label: 'Semua',
                isSelected: state.selectedCategory == null,
              ),
              ...state.categories.map(
                (category) => CategoryChip(
                  category: category,
                  label: category,
                  isSelected: state.selectedCategory == category,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}