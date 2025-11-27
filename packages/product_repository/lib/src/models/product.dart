import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product(this.id, {
    required this.namaProduk,
    required this.kategori,
    required this.harga,
    required this.stok,
    this.fotoUrl,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String namaProduk;
  final String kategori;
  final double harga;
  final int stok;
  final String? fotoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
        id,
        namaProduk,
        kategori,
        harga,
        stok,
        fotoUrl,
        createdAt,
        updatedAt,
      ];

  static const empty = Product(
    null,
    namaProduk: '',
    kategori: '',
    harga: 0,
    stok: 0,
  );

  bool get isOutOfStock => stok <= 0;
  bool get hasStock => stok > 0;

  Product copyWith({
    String? id,
    String? namaProduk,
    String? kategori,
    double? harga,
    int? stok,
    String? fotoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id ?? this.id,
      namaProduk: namaProduk ?? this.namaProduk,
      kategori: kategori ?? this.kategori,
      harga: harga ?? this.harga,
      stok: stok ?? this.stok,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null && id!.isNotEmpty) 'id': id,
      'nama_produk': namaProduk,
      'kategori': kategori,
      'harga': harga,
      'stok': stok,
      'foto_url': fotoUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'] as String,
      namaProduk: json['nama_produk'] as String,
      kategori: json['kategori'] as String,
      harga: (json['harga'] as num).toDouble(),
      stok: json['stok'] as int,
      fotoUrl: json['foto_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }
}