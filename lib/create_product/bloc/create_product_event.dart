part of 'create_product_bloc.dart';

sealed class CreateProductEvent extends Equatable {
  const CreateProductEvent();

  @override
  List<Object> get props => [];
}

final class CreateProductNameChanged extends CreateProductEvent {
  const CreateProductNameChanged(this.productName);

  final String productName;

  @override
  List<Object> get props => [productName];
}

final class CreateProductCategoryChanged extends CreateProductEvent {
  const CreateProductCategoryChanged(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}

final class CreateProductPriceChanged extends CreateProductEvent {
  const CreateProductPriceChanged(this.price);

  final double price;

  @override
  List<Object> get props => [price];
}

final class CreateProductStockChanged extends CreateProductEvent {
  const CreateProductStockChanged(this.stock);

  final int stock;

  @override
  List<Object> get props => [stock];
}

final class CreateProductPhotoUrlChanged extends CreateProductEvent {
  const CreateProductPhotoUrlChanged(this.photoUrl);

  final String photoUrl;

  @override
  List<Object> get props => [photoUrl];
}

final class CreateProductSubmitted extends CreateProductEvent {
  const CreateProductSubmitted();
}

final class CreateProductLoadRequested extends CreateProductEvent {
  const CreateProductLoadRequested();
}

