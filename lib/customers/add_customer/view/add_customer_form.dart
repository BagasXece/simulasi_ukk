import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simulasi_ukk/app_routes.dart';
import 'package:simulasi_ukk/customers/add_customer/add_customer.dart';

class AddCustomerForm extends StatelessWidget {
  const AddCustomerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCustomerBloc, AddCustomerState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Add Customer Failed: ${state.errorMessage}'),
              ),
            );
        }

        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Customer Added Successfully')),
            );

          Future.delayed(const Duration(milliseconds: 1000), () {
            if (AppRoutes.canPop(context)) {
              AppRoutes.pop(context);
            }
          });
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomerNameInput(),
            const SizedBox(height: 16,),
            CustomerPhoneInput(),
            const SizedBox(height: 16,),
            CustomerAddressInput(),
            const SizedBox(height: 24,),
            SubmitButton()
          ],
        ),
      ),
    );
  }
}
