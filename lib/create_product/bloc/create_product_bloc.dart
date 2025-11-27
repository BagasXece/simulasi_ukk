import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:product_repository/product_repository.dart';
import 'package:simulasi_ukk/create_product/models/models.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  CreateProductBloc({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(const CreateProductState()) {
    on<CreateProductNameChanged>(_onCreateProductNameChanged);
    on<CreateProductCategoryChanged>(_onCreateProductCategoryChanged);
    on<CreateProductPriceChanged>(_onCreateProductPriceChanged);
    on<CreateProductStockChanged>(_onCreateProductStockChanged);
    on<CreateProductPhotoUrlChanged>(_onProductPhotoUrlChanged);
    on<CreateProductSubmitted>(_onProductSubmitted);
    on<CreateProductLoadRequested>(_onProductLoadRequested);
  }

  final ProductRepository _productRepository;

  void _onCreateProductNameChanged(
    CreateProductNameChanged event,
    Emitter<CreateProductState> emit,
  ) {
    final productName = ProductName.dirty(event.productName);

    emit(
      state.copyWith(
        productName: productName,
        isValid: Formz.validate([
          productName,
          state.category,
          state.price,
          state.stock,
        ]),
      ),
    );
  }

  void _onCreateProductCategoryChanged(
    CreateProductCategoryChanged event,
    Emitter<CreateProductState> emit,
  ) {
    final category = Category.dirty(event.category);

    emit(
      state.copyWith(
        category: category,
        isValid: Formz.validate([
          state.productName,
          category,
          state.price,
          state.stock,
        ]),
      ),
    );
  }

  void _onCreateProductPriceChanged(
    CreateProductPriceChanged event,
    Emitter<CreateProductState> emit,
  ) {
    final price = Price.dirty(event.price);

    emit(
      state.copyWith(
        price: price,
        isValid: Formz.validate([
          state.productName,
          state.category,
          price,
          state.stock,
        ]),
      ),
    );
  }

  void _onCreateProductStockChanged(
    CreateProductStockChanged event,
    Emitter<CreateProductState> emit,
  ) {
    final stock = Stock.dirty(event.stock);

    emit(
      state.copyWith(
        stock: stock,
        isValid: Formz.validate([
          state.productName,
          state.category,
          state.price,
          stock,
        ]),
      ),
    );
  }

  void _onProductPhotoUrlChanged(
    CreateProductPhotoUrlChanged event,
    Emitter<CreateProductState> emit,
  ) {
    final photoUrl = ImgUrl.dirty(event.photoUrl);
    emit(state.copyWith(imgUrl: photoUrl));
  }

  Future<void> _onProductSubmitted(
    CreateProductSubmitted event,
    Emitter<CreateProductState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        final product = Product(
          null,
          namaProduk: state.productName.value,
          kategori: state.category.value,
          harga: state.price.value,
          stok: state.stock.value,
          fotoUrl: state.imgUrl.value.isNotEmpty ? state.imgUrl.value : null
        );

        await _productRepository.createProduct(product);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString()
        ));
      }
    }
  }

  Future<void> _onProductLoadRequested(
    CreateProductLoadRequested event,
    Emitter<CreateProductState> emit
  ) async {
    emit(state.copyWith(productStatus: CreateProductStatus.loading));
    try {
      final products = await _productRepository.getProducts();
      emit(state.copyWith(
        productStatus: CreateProductStatus.success,
        products: products
      ));
    } catch (e) {
      emit(state.copyWith(
        productStatus: CreateProductStatus.failure,
        errorMessage: e.toString()
      ));
    }
  }
}
