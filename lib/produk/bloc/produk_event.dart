part of 'produk_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class LoadProducts extends ProductEvent {
  const LoadProducts();
}

final class LoadProductsByCategory extends ProductEvent {
  const LoadProductsByCategory(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}

final class SearchProducts extends ProductEvent {
  const SearchProducts(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}

final class LoadProductDetail extends ProductEvent {
  const LoadProductDetail(this.productId);

  final String productId;

  @override
  List<Object> get props => [productId];
}

final class LoadCategories extends ProductEvent {
  const LoadCategories();
}