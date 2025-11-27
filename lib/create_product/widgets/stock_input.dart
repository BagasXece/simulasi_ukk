import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/create_product/create_product.dart';

class StockInput extends StatelessWidget {
  const StockInput({super.key});

  @override
  Widget build(BuildContext context) {

    final displayError = context.select(
      (CreateProductBloc bloc) => bloc.state.stock.displayError,
    );

    return TextField(
      onChanged: (value) {
        final stock = int.tryParse(value) ?? 0;
        context.read<CreateProductBloc>().add(CreateProductStockChanged(stock));
      },
      decoration: InputDecoration(
        labelText: 'Stock',
        errorText: displayError == StockValidationError.invalid
          ? 'Stock invalid format'
          : null
      ),
    );
  }
}