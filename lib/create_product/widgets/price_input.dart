
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/create_product/create_product.dart';

class PriceInput extends StatelessWidget {
  const PriceInput({super.key});

  @override
  Widget build(BuildContext context) {

    final displayError = context.select(
      (CreateProductBloc bloc) => bloc.state.price.displayError,
    );

    return TextField(
      onChanged: (value) {
        final price = double.tryParse(value) ?? 1;
        context.read<CreateProductBloc>().add(CreateProductPriceChanged(price));
      },
      decoration: InputDecoration(
        labelText: 'Price',
        errorText: displayError == PriceValidationError.invalid
          ? 'Price invalid format'
          : null
      ),
    );
  }
}