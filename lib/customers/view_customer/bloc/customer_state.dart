part of 'customer_bloc.dart';


enum CustomerStatus { initial, loading, success, failure }

class CustomerState extends Equatable {
  const CustomerState({
    this.status = CustomerStatus.initial,
    this.customers = const [],
    this.searchQuery = '',
    this.selectedCustomer,
    this.errorMessage
  });

  final CustomerStatus status;
  final List<Customer> customers;
  final String searchQuery;
  final Customer? selectedCustomer;
  final String? errorMessage;

  @override
  List<Object?> get props => [
    status,
    customers,
    searchQuery,
    selectedCustomer,
    errorMessage
  ];

  CustomerState copyWith({
    CustomerStatus? status,
    List<Customer>? customers,
    String? searchQuery,
    Customer? selectedCustomer,
    String? errorMessage
  }) {
    return CustomerState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}