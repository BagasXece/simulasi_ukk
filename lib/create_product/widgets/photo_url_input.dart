import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/create_product/bloc/create_product_bloc.dart';

class PhotoUrlInput extends StatelessWidget {
  const PhotoUrlInput({super.key});

  @override
  Widget build(BuildContext context) {

    return TextField(
      onChanged: (photoUrl) {
        context.read<CreateProductBloc>().add(CreateProductPhotoUrlChanged(photoUrl));
      },
      decoration: InputDecoration(
        labelText: 'Photo Url'
      ),
    );
  }
}