part of 'add_customer_bloc.dart';

enum AddCustomerStatus { initial, loading, success, failure }

class AddCustomerState extends Equatable {
  const AddCustomerState({
    this.status = FormzSubmissionStatus.initial,
    this.customerStatus = AddCustomerStatus.initial,
    this.customerName = const CustomerName.pure(),
    this.customerPhone = const CustomerPhone.pure(),
    this.customerAddress = const CustomerAddress.pure(),
    this.isValid = false,
    this.customers = const [],
    this.errorMessage
  });

  final FormzSubmissionStatus status;
  final AddCustomerStatus customerStatus;
  final CustomerName customerName;
  final CustomerPhone customerPhone;
  final CustomerAddress customerAddress;
  final bool isValid;
  final List<Customer> customers;
  final String? errorMessage;

  AddCustomerState copyWith({
    FormzSubmissionStatus? status,
    AddCustomerStatus? customerStatus,
    CustomerName? customerName,
    CustomerPhone? customerPhone,
    CustomerAddress? customerAddress,
    bool? isValid,
    List<Customer>? customers,
    String? errorMessage
  }) {
    return AddCustomerState(
      status: status ?? this.status,
      customerStatus: customerStatus ?? this.customerStatus,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerAddress: customerAddress ?? this.customerAddress,
      isValid: isValid ?? this.isValid,
      customers: customers ?? this.customers,
      errorMessage: errorMessage
    );
  }

  @override
  List<Object?> get props => [
    status,
    customerStatus,
    customerName,
    customerPhone,
    customerAddress,
    customers
  ];
}