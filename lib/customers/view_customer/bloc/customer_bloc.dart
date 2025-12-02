import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc({required CustomerRepository customerrepository})
    : _customerRepository = customerrepository,
      super(const CustomerState()) {
        on<LoadCustomers>(_onLoadCustomers);
        on<SearchCustomer>(_onSearchCustomer);
        on<LoadCustomerDetail>(_onLoadCustomerDetail);
      }

  final CustomerRepository _customerRepository;

  Future<void> _onLoadCustomers(
    LoadCustomers event,
    Emitter<CustomerState> emit,
  ) async {
    emit(state.copyWith(status: CustomerStatus.loading));
    try {
      final customers = await _customerRepository.getCustomers();
      emit(
        state.copyWith(
          status: CustomerStatus.success,
          customers: customers,
          searchQuery: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CustomerStatus.failure,
          errorMessage: 'Gagal memuat pelanggan: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onSearchCustomer(
    SearchCustomer event,
    Emitter<CustomerState> emit
  ) async {
    if (event.query.isEmpty) {
      add(const LoadCustomers());
      return;
    }

    emit(state.copyWith(status: CustomerStatus.loading));

    try {
      final customers = await _customerRepository.searchCustomers(event.query);
      emit(state.copyWith(
        status: CustomerStatus.success,
        customers: customers,
        searchQuery: event.query,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CustomerStatus.failure,
        errorMessage: 'Gagal mencari pelanggan: ${e.toString()}'
      ));
    }
  }

  Future<void> _onLoadCustomerDetail(
    LoadCustomerDetail event,
    Emitter<CustomerState> emit
  ) async {
    emit(state.copyWith(selectedCustomer: null));
    try {
      final customer = await _customerRepository.getCustomer(event.customerId);
      emit(state.copyWith(selectedCustomer: customer));
    } catch (e) {
      emit(state.copyWith(
        status: CustomerStatus.failure,
        errorMessage: 'Gagal memuat detail: ${e.toString()}'
      ));
    }
  }
}
