part of 'customer_bloc.dart';

sealed class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCustomers extends CustomerEvent {
  const LoadCustomers();
}

final class SearchCustomer extends CustomerEvent {
  const SearchCustomer(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class LoadCustomerDetail extends CustomerEvent {
  const LoadCustomerDetail(this.customerId);

  final String customerId;

  @override
  List<Object?> get props => [customerId];
}