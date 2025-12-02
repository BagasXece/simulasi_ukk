import 'package:customer_repository/src/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerRepository {
  final SupabaseClient _supabaseClient;

  CustomerRepository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  Future<Customer?> getCustomer(String id) async {
    try {
      final response = await _supabaseClient
          .from('pelanggan')
          .select()
          .eq('id', id)
          .single();
      return Customer.fromJson(response);
    } catch (_) {
      return null;
    }
  }

  Future<List<Customer>> getCustomers({int limit = 100}) async {
    try {
      var filter = _supabaseClient.from('pelanggan').select();

      final response = await filter.limit(limit);

      return (response as List)
          .map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get customers: $e');
    }
  }

  Future<List<Customer>> searchCustomers(String queryText) async {
    try {
      final response = await _supabaseClient
          .from('pelanggan')
          .select()
          .ilike('nama', '%$queryText%')
          .order('nama');

      return (response as List)
          .map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search customers: $e');
    }
  }

  Future<void> createCustomer(Customer customer) async {
    try {
      await _supabaseClient.from('pelanggan').insert(customer.toJson());
    } catch (e) {
      throw Exception('Failed to create customer: $e');
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    try {
      await _supabaseClient
          .from('pelanggan')
          .update(customer.toJson())
          .eq('id', customer.id!);
    } catch (e) {
      throw Exception('Failed to update customer: $e');
    }
  }

  Future<void> deleteCustomer(String id) async {
    try {
      await _supabaseClient.from('pelanggan').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete customer: $e');
    }
  }
}
