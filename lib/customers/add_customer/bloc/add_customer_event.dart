part of 'add_customer_bloc.dart';

sealed class AddCustomerEvent extends Equatable {
  const AddCustomerEvent();

  @override
  List<Object?> get props => [];
}

final class AddCustomerNameChanged extends AddCustomerEvent {
  const AddCustomerNameChanged(this.customerName);

  final String customerName;

  @override
  List<Object?> get props => [customerName];
}

final class AddCustomerPhoneChanged extends AddCustomerEvent {
  const AddCustomerPhoneChanged(this.customerPhone);

  final String customerPhone;

  @override
  List<Object?> get props => [customerPhone];
}

final class AddCustomerAddressChanged extends AddCustomerEvent {
  const AddCustomerAddressChanged(this.customerAddress);

  final String customerAddress;

  @override
  List<Object?> get props => [customerAddress];
}


final class AddCustomerSubmitted extends AddCustomerEvent {
  const AddCustomerSubmitted();
}

final class AddCustomerLoadRequested extends AddCustomerEvent {
  const AddCustomerLoadRequested();
}