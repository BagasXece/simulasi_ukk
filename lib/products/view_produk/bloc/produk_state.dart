part of 'produk_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.selectedCategory,
    this.searchQuery = '',
    this.selectedProduct,
    this.errorMessage,
  });

  final ProductStatus status;
  final List<Product> products;
  final List<String> categories;
  final String? selectedCategory;
  final String searchQuery;
  final Product? selectedProduct;
  final String? errorMessage;

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
    Product? selectedProduct,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        categories,
        selectedCategory,
        searchQuery,
        selectedProduct,
        errorMessage,
      ];
}