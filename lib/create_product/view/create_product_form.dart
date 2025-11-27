import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simulasi_ukk/app_routes.dart';
import 'package:simulasi_ukk/create_product/create_product.dart';
import 'package:simulasi_ukk/create_product/widgets/widgets.dart';

class CreateProductForm extends StatelessWidget {
  const CreateProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProductBloc, CreateProductState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Add Product Failed: ${state.errorMessage}'),
              ),
            );
        }

        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Product Added Successfully')),
            );

          Future.delayed(const Duration(milliseconds: 1500), () {
            if (AppRoutes.canPop(context)) {
              AppRoutes.pop(context);
            }
          });
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProductNameInput(),
            const SizedBox(height: 16,),
            CategoryInput(),
            const SizedBox(height: 16,),
            PriceInput(),
            const SizedBox(height: 16,),
            StockInput(),
            const SizedBox(height: 16,),
            PhotoUrlInput(),
            const SizedBox(height: 24,),
            SubmitButton()
          ],
        ),
      ),
    );
  }
}
