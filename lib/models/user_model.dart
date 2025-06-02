class UserModel {
  final int id;
  final String nik;
  final String name;
  final String? jabatan;
  final String? status;
  final String? departemen;
  final String? kemandoran;
  final String? noHp;

  UserModel({
    required this.id,
    required this.nik,
    required this.name,
    this.jabatan,
    this.status,
    this.departemen,
    this.kemandoran,
    this.noHp,
  });

  // Factory method to create a UserModel from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nik: map['nik'],
      name: map['name'],
      jabatan: map['jabatan'],
      status: map['status'],
      departemen: map['departemen'],
      kemandoran: map['kemandoran'],
      noHp: map['no_hp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'name': name,
      'jabatan': jabatan,
      'status': status,
      'departemen': departemen,
      'kemandoran': kemandoran,
      'no_hp': noHp,
    };
  }
}
