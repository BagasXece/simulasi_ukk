import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/customers/add_customer/add_customer.dart';

class CustomerAddressInput extends StatelessWidget {
  const CustomerAddressInput({super.key});

  @override
  Widget build(BuildContext context) {

    // final displayError = context.select(
    //   (AddCustomerBloc bloc) => bloc.state.customerAddress.displayError,
    // );

    return TextField(
      onChanged: (customerAddress) {
        context.read<AddCustomerBloc>().add(AddCustomerAddressChanged(customerAddress));
      },
      decoration: InputDecoration(
        labelText: 'Customer Address',        
      ),
    );
  }
}