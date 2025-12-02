import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simulasi_ukk/customers/add_customer/models/models.dart';

part 'add_customer_event.dart';
part 'add_customer_state.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  AddCustomerBloc({required CustomerRepository customerRepository})
    : _customerRepository = customerRepository,
      super(const AddCustomerState()) {
    on<AddCustomerNameChanged>(_onAddCustomerNameChanged);
    on<AddCustomerPhoneChanged>(_onAddCustomerPhoneChanged);
    on<AddCustomerAddressChanged>(_onAddCustomerAddressChanged);
    on<AddCustomerSubmitted>(_onCustomerSubmitted);
    on<AddCustomerLoadRequested>(_onCustomerLoadRequested);
  }

  final CustomerRepository _customerRepository;

  void _onAddCustomerNameChanged(
    AddCustomerNameChanged event,
    Emitter<AddCustomerState> emit,
  ) {
    final customerName = CustomerName.dirty(event.customerName);

    emit(
      state.copyWith(
        customerName: customerName,
        isValid: Formz.validate([customerName]),
      ),
    );
  }

  void _onAddCustomerPhoneChanged(
    AddCustomerPhoneChanged event,
    Emitter<AddCustomerState> emit,
  ) {
    final customerPhone = CustomerPhone.dirty(event.customerPhone);

    emit(state.copyWith(customerPhone: customerPhone));
  }

  void _onAddCustomerAddressChanged(
    AddCustomerAddressChanged event,
    Emitter<AddCustomerState> emit,
  ) {
    final customerAddress = CustomerAddress.dirty(event.customerAddress);

    emit(state.copyWith(customerAddress: customerAddress));
  }

  Future<void> _onCustomerSubmitted(
    AddCustomerSubmitted event,
    Emitter<AddCustomerState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }

    try {
      final customer = Customer(
        null,
        nama: state.customerName.value,
        kontak: state.customerPhone.value.isNotEmpty
            ? state.customerPhone.value
            : null,
        alamat: state.customerAddress.value.isNotEmpty
            ? state.customerAddress.value
            : null,
      );

      await _customerRepository.createCustomer(customer);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString()
      ));
    }
  }

  Future<void> _onCustomerLoadRequested(
    AddCustomerLoadRequested event,
    Emitter<AddCustomerState> emit
  ) async {
    emit(state.copyWith(customerStatus: AddCustomerStatus.loading));
    try {
      final customers = await _customerRepository.getCustomers();
      emit(state.copyWith(
        customerStatus: AddCustomerStatus.success,
        customers: customers
      ));
    } catch (e) {
      emit(state.copyWith(
        customerStatus: AddCustomerStatus.failure,
        errorMessage: e.toString()
      ));
    }
  }
}
