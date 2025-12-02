import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/customers/add_customer/add_customer.dart';

class CustomerPhoneInput extends StatelessWidget {
  const CustomerPhoneInput({super.key});

  @override
  Widget build(BuildContext context) {

    final displayError = context.select(
      (AddCustomerBloc bloc) => bloc.state.customerPhone.displayError,
    );

    return TextField(
      onChanged: (customerPhone) {
        context.read<AddCustomerBloc>().add(AddCustomerPhoneChanged(customerPhone));
      },
      decoration: InputDecoration(
        labelText: 'Customer phone',
        errorText: displayError == CustomerPhoneValidationError.invalid
          ? 'Phone invalid format'
          : displayError == CustomerPhoneValidationError.tooShort
            ? 'Phone must be at least 8 characters'
            : displayError == CustomerPhoneValidationError.tooLong
              ? 'Phone must be a maximum of 13 characters'
              : null
      ),
    );
  }
}