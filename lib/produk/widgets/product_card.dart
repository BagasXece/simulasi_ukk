import 'package:flutter/material.dart';
import 'package:product_repository/product_repository.dart';
import 'package:simulasi_ukk/produk/produk.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showProductDetail(context, product);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                  image: product.fotoUrl != null
                      ? DecorationImage(
                          image: NetworkImage(product.fotoUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: product.fotoUrl == null
                    ? Icon(
                        Icons.inventory_2_outlined,
                        size: 40,
                        color: Colors.grey.shade400,
                      )
                    : null,
              ),
              const SizedBox(height: 8),
              
              // Product Name
              Text(
                product.namaProduk,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              
              // Category
              Text(
                product.kategori,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              
              // Price
              Text(
                _formatPrice(product.harga),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              const Spacer(),
              
              // Stock Info
              Row(
                children: [
                  Icon(
                    Icons.inventory_2,
                    size: 12,
                    color: product.hasStock ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    product.hasStock ? 'Stok: ${product.stok}' : 'Stok Habis',
                    style: TextStyle(
                      fontSize: 11,
                      color: product.hasStock ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  void _showProductDetail(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product.namaProduk),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (product.fotoUrl != null)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(product.fotoUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              DetailItem(label: 'Kategori', value: product.kategori),
              DetailItem(label: 'Harga', value: _formatPrice(product.harga)),
              DetailItem(label: 'Stok', value: product.stok.toString()),
              if (product.createdAt != null)
                DetailItem(
                  label: 'Ditambahkan',
                  value: _formatDate(product.createdAt!),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}