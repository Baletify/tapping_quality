class UserModel {
  final int id;
  final String nik;
  final String name;
  final String role;
  final String? jabatan;
  final String? status;
  final String? departemen;
  final String? kemandoran;
  final String? email;
  final String? password;
  final String? noHp;

  UserModel({
    required this.id,
    required this.nik,
    required this.name,
    required this.role,
    this.jabatan,
    this.status,
    this.departemen,
    this.kemandoran,
    this.email,
    this.password,
    this.noHp,
  });

  // Factory method to create a UserModel from a Map (e.g., from SQLite or API)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nik: map['nik'],
      name: map['name'],
      role: map['role'],
      jabatan: map['jabatan'],
      status: map['status'],
      departemen: map['departemen'],
      kemandoran: map['kemandoran'],
      email: map['email'],
      password: map['password'],
      noHp: map['no_hp'],
    );
  }

  // Convert UserModel to a Map (e.g., for saving to SQLite or API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'name': name,
      'role': role,
      'jabatan': jabatan,
      'status': status,
      'departemen': departemen,
      'kemandoran': kemandoran,
      'email': email,
      'password': password,
      'no_hp': noHp,
    };
  }
  
}