import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository,
       super(const ProductState()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<SearchProducts>(_onSearchProducts);
    on<LoadProductDetail>(_onLoadProductDetail);
    on<LoadCategories>(_onLoadCategories);
  }

  final ProductRepository _productRepository;

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = await _productRepository.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
        selectedCategory: null,
        searchQuery: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: 'Gagal memuat produk: ${e.toString()}',
      ));
    }
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = await _productRepository.getProductsByKategori(event.category);
      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
        selectedCategory: event.category,
        searchQuery: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: 'Gagal memuat produk kategori ${event.category}: ${e.toString()}',
      ));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const LoadProducts());
      return;
    }

    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = await _productRepository.searchProducts(event.query);
      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
        searchQuery: event.query,
        selectedCategory: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: 'Gagal mencari produk: ${e.toString()}',
      ));
    }
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(selectedProduct: null));
    try {
      final product = await _productRepository.getProduct(event.productId);
      emit(state.copyWith(selectedProduct: product));
    } catch (e) {
      // Handle error silently for now
      print('Error loading product detail: $e');
    }
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final categories = await _productRepository.getKategories();
      emit(state.copyWith(categories: categories));
    } catch (e) {
      // Handle error silently, but we can show a snackbar if needed
      print('Error loading categories: $e');
    }
  }
}