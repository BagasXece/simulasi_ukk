import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  const Customer(
    this.id, {
    required this.nama,
    this.kontak,
    this.alamat,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String nama;
  final String? kontak;
  final String? alamat;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, nama, kontak, alamat, createdAt, updatedAt];

  static const empty = Customer(null, nama: '');

  bool get hasKontak => kontak != null && kontak!.isNotEmpty;
  bool get hasAlamat => alamat != null && alamat!.isNotEmpty;

  Customer copyWith({
    String? id,
    String? nama,
    String? kontak,
    String? alamat,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id ?? this.id,
      nama: nama ?? this.nama,
      kontak: kontak ?? this.kontak,
      alamat: alamat ?? this.alamat,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null && id!.isNotEmpty) 'id': id,
      'nama': nama,
      'kontak': kontak,
      'alamat': alamat,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      json['id'] as String,
      nama: json['nama'] as String,
      kontak: json['kontak'],
      alamat: json['alamat'],
      createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'] as String)
        : null,
      updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'] as String)
        : null
    );
  }
}
