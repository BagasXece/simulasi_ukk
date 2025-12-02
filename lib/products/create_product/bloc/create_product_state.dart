part of 'create_product_bloc.dart';

enum CreateProductStatus {initial, loading, success, failure}

class CreateProductState extends Equatable {
  const CreateProductState({
    this.status = FormzSubmissionStatus.initial,
    this.productStatus = CreateProductStatus.initial,
    this.productName = const ProductName.pure(),
    this.category = const Category.pure(),
    this.price = const Price.pure(),
    this.stock = const Stock.pure(),
    this.imgUrl = const ImgUrl.pure(),
    this.isValid = false,
    this.products = const [],
    this.errorMessage
  });

  final FormzSubmissionStatus status;
  final CreateProductStatus productStatus;
  final ProductName productName;
  final Category category;
  final Price price;
  final Stock stock;
  final ImgUrl imgUrl;
  final bool isValid;
  final List<Product> products;
  final String? errorMessage;

  CreateProductState copyWith({
    FormzSubmissionStatus? status,
    CreateProductStatus? productStatus,
    ProductName? productName,
    Category? category,
    Price? price,
    Stock? stock,
    ImgUrl? imgUrl,
    bool? isValid,
    List<Product>? products,
    String? errorMessage 
  }) {
    return CreateProductState(
      status: status ?? this.status,
      productStatus: productStatus ?? this.productStatus,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      imgUrl: imgUrl ?? this.imgUrl,
      isValid: isValid ?? this.isValid,
      products: products ?? this.products,
      errorMessage: errorMessage
    );
  }

  @override
  List<Object?> get props => [
    status,
    productStatus,
    productName,
    category,
    price,
    stock,
    imgUrl,
    products
  ];
}