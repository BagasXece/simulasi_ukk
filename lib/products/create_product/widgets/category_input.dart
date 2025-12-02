
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/products/create_product/create_product.dart';

class CategoryInput extends StatelessWidget {
  const CategoryInput({super.key});

  @override
  Widget build(BuildContext context) {

    final displayError = context.select(
      (CreateProductBloc bloc) => bloc.state.category.displayError,
    );

    return TextField(
      onChanged: (category) {
        context.read<CreateProductBloc>().add(CreateProductCategoryChanged(category));
      },
      decoration: InputDecoration(
        labelText: 'Category',
        errorText: displayError == CategoryValidationError.empty
          ? 'Category cannot be empty'
          : null
      ),
    );
  }
}