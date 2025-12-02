import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/customers/add_customer/add_customer.dart';

class CustomerNameInput extends StatelessWidget {
  const CustomerNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (AddCustomerBloc bloc) => bloc.state.customerName.displayError
    );
    return TextField(
      onChanged: (customerName) {
        context.read<AddCustomerBloc>().add(AddCustomerNameChanged(customerName));
      },
      decoration: InputDecoration(
        labelText: 'Customer Name',
        errorText: displayError == CustomerNameValidationError.empty
          ? 'Customer Name cannot be empty'
          : null
      ),
    );
  }
}