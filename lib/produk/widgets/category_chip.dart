import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/produk/produk.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    required this.category,
    required this.label,
    required this.isSelected,
  });

  final String? category;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {
          if (category == null) {
            context.read<ProductBloc>().add(const LoadProducts());
          } else {
            context.read<ProductBloc>().add(LoadProductsByCategory(category!));
          }
        },
        backgroundColor: Colors.grey.shade200,
        selectedColor: Colors.blue.shade100,
        checkmarkColor: Colors.blue.shade700,
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue.shade700 : Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}