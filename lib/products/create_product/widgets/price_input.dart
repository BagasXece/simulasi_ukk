
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/products/create_product/create_product.dart';

class PriceInput extends StatelessWidget {
  const PriceInput({super.key});

  @override
  Widget build(BuildContext context) {

    final displayError = context.select(
      (CreateProductBloc bloc) => bloc.state.price.displayError,
    );

    return TextField(
      onChanged: (value) {
        context.read<CreateProductBloc>().add(CreateProductPriceChanged(value));
      },
      decoration: InputDecoration(
        labelText: 'Price',
        errorText: displayError == PriceValidationError.invalid
          ? 'Price invalid format'
          : displayError == PriceValidationError.empty
            ? 'Price cannot be empty'
            : null
      ),
    );
  }
}