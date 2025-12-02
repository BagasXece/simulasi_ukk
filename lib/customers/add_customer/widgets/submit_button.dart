import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simulasi_ukk/customers/add_customer/add_customer.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (AddCustomerBloc bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (AddCustomerBloc bloc) => bloc.state.isValid,
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isValid
            ? () => context.read<AddCustomerBloc>().add(
                const AddCustomerSubmitted(),
              )
            : null,
        child: const Text('Add Customer'),
      ),
    );
  }
}
