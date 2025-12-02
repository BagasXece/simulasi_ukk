import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulasi_ukk/customers/view_customer/view_customer.dart';
import 'package:simulasi_ukk/customers/view_customer/widgets/widgets.dart';

class CustomersList extends StatelessWidget {
  const CustomersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        switch (state.status) {
          case CustomerStatus.initial:
          case CustomerStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case CustomerStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Gagal memuat pelanggan',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.errorMessage ?? 'Terjadi kesalahan',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CustomerBloc>().add(const LoadCustomers());
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            );
          case CustomerStatus.success:
            if (state.customers.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey.shade400,),
                    const SizedBox(height: 16,),
                    Text(
                      'Tidak ada pelanggan',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      state.searchQuery.isNotEmpty
                        ? 'Tidak ditemukan pelanggan dengan kata kunci "${state.searchQuery}"'
                        : 'Belum ada pelanggan yang terdaftar',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    )
                  ],
                ),
              );
            }
          return ListView.builder(
            itemCount: state.customers.length,
            itemBuilder: (context, index) {
              final customer = state.customers[index];
              return CustomersCard(customer: customer);
            }
            );
        }
      },
    );
  }
}
