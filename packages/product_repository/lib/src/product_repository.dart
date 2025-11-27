import 'package:product_repository/src/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final SupabaseClient _supabaseClient;

  ProductRepository({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  /* ---------- SINGLE PRODUCT ---------- */
  Future<Product?> getProduct(String id) async {
    try {
      final response =
          await _supabaseClient.from('produk').select().eq('id', id).single();
      return Product.fromJson(response);
    } catch (_) {
      return null;
    }
  }

  /* ---------- ALL PRODUCTS + FILTER/SORT ---------- */
  Future<List<Product>> getProducts({
    String? kategori,
    bool sortByHarga = false,
    bool sortByStok = false,
    int limit = 100,
  }) async {
    try {
      var filter =
      _supabaseClient.from('produk').select();

  if (kategori != null) filter = filter.eq('kategori', kategori);

  // 2. Tambahkan transform & eksekusi dalam satu rantai baru
  final response = await filter
      .order(sortByHarga ? 'harga' : 'created_at')
      .limit(limit);

  return (response as List)
      .map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList();
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  /* ---------- BY CATEGORY ---------- */
  Future<List<Product>> getProductsByKategori(String kategori) async {
    try {
      final response = await _supabaseClient
          .from('produk')
          .select()
          .eq('kategori', kategori)
          .order('nama_produk');
      return (response as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get products by kategori: $e');
    }
  }

  /* ---------- SEARCH ---------- */
  Future<List<Product>> searchProducts(String queryText) async {
    try {
      final response = await _supabaseClient
          .from('produk')
          .select()
          .ilike('nama_produk', '%$queryText%')
          .order('nama_produk');
      return (response as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  /* ---------- CREATE ---------- */
  Future<void> createProduct(Product product) async {
    try {
      await _supabaseClient.from('produk').insert(product.toJson());
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  /* ---------- UPDATE ---------- */
  Future<void> updateProduct(Product product) async {
    try {
      await _supabaseClient
          .from('produk')
          .update(product.toJson())
          .eq('id', product.id!);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  /* ---------- UPDATE STOCK ---------- */
  Future<void> updateProductStock(String productId, int newStock) async {
    try {
      await _supabaseClient.from('produk').update({
        'stok': newStock,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', productId);
    } catch (e) {
      throw Exception('Failed to update stock: $e');
    }
  }

  /* ---------- DELETE ---------- */
  Future<void> deleteProduct(String id) async {
    try {
      await _supabaseClient.from('produk').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  /* ---------- LIST CATEGORIES ---------- */
  Future<List<String>> getKategories() async {
    try {
      final response =
          await _supabaseClient.from('produk').select('kategori');
      final kategories = (response as List)
          .map((e) => e['kategori'] as String)
          .toSet()
          .toList();
      kategories.sort();
      return kategories;
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  /* ---------- LOW STOCK ---------- */
  Future<List<Product>> getLowStockProducts() async {
    try {
      final response = await _supabaseClient
          .from('produk')
          .select()
          .lt('stok', 10)
          .order('stok');
      return (response as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get low-stock products: $e');
    }
  }

  /* ---------- BULK UPSERT ---------- */
  Future<void> bulkUpdateProducts(List<Product> products) async {
    try {
      await _supabaseClient
          .from('produk')
          .upsert(products.map((p) => p.toJson()).toList());
    } catch (e) {
      throw Exception('Failed to bulk-update products: $e');
    }
  }

  /* ---------- MULTIPLE CATEGORIES (client-side filter) ---------- */
  Future<List<Product>> getProductsByMultipleKategories(
      List<String> kategories) async {
    if (kategories.isEmpty) return getProducts();
    final all = await getProducts();
    return all.where((p) => kategories.contains(p.kategori)).toList();
  }

  /* ---------- PRICE RANGE ---------- */
  Future<List<Product>> getProductsByPriceRange(
      double minPrice, double maxPrice) async {
    try {
      final response = await _supabaseClient
          .from('produk')
          .select()
          .gte('harga', minPrice)
          .lte('harga', maxPrice)
          .order('harga');
      return (response as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get products by price range: $e');
    }
  }
}