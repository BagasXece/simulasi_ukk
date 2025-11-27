import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/create_product/create_product.dart';

class ProductNameInput extends StatelessWidget {
  const ProductNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (CreateProductBloc bloc) => bloc.state.productName.displayError,
    );

    return TextField(
      onChanged: (productName) {
        context.read<CreateProductBloc>().add(CreateProductNameChanged(productName));
      },
      decoration: InputDecoration(
        labelText: 'Product Name',
        errorText: displayError == ProductNameValidationError.empty
          ? 'Product Name cannot be empty'
          : null
      ),
    );
  }
}
