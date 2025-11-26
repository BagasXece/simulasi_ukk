import 'package:equatable/equatable.dart';

class Users extends Equatable {
  const Users(
    this.id, {
    this.email,
    this.name,
    this.role = 'petugas',
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String? email;
  final String? name;
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, email, name, role, createdAt, updatedAt];

  static const empty = Users('-');

  bool get isAdmin => role == 'admin';
  bool get isPetugas => role == 'petugas';

  Users copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Users(
      id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': name,
      'role': role,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      json['id'] as String,
      email: json['email'] as String?,
      name: json['full_name'] as String?,
      role: json['role'] as String? ?? 'petugas',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }
}