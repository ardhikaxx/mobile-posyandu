import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(name: 'no_kk')
  final int noKk;
  
  @JsonKey(name: 'nik_ibu')
  final String nikIbu;
  
  @JsonKey(name: 'nama_ibu')
  final String namaIbu;
  
  @JsonKey(name: 'tempat_lahir_ibu')
  final String tempatLahirIbu;
  
  @JsonKey(name: 'tanggal_lahir_ibu')
  final String tanggalLahirIbu;
  
  @JsonKey(name: 'gol_darah_ibu')
  final String golDarahIbu;
  
  @JsonKey(name: 'nik_ayah')
  final String nikAyah;
  
  @JsonKey(name: 'nama_ayah')
  final String namaAyah;
  
  final String alamat;
  final String telepon;
  
  @JsonKey(name: 'email_orang_tua')
  final String emailOrangTua;
  
  @JsonKey(name: 'created_at')
  final String createdAt;
  
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  UserData({
    required this.noKk,
    required this.nikIbu,
    required this.namaIbu,
    required this.tempatLahirIbu,
    required this.tanggalLahirIbu,
    required this.golDarahIbu,
    required this.nikAyah,
    required this.namaAyah,
    required this.alamat,
    required this.telepon,
    required this.emailOrangTua,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}