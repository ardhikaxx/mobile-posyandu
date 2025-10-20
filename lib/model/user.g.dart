// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  noKk: (json['no_kk'] as num).toInt(),
  nikIbu: json['nik_ibu'] as String,
  namaIbu: json['nama_ibu'] as String,
  tempatLahirIbu: json['tempat_lahir_ibu'] as String,
  tanggalLahirIbu: json['tanggal_lahir_ibu'] as String,
  golDarahIbu: json['gol_darah_ibu'] as String,
  nikAyah: json['nik_ayah'] as String,
  namaAyah: json['nama_ayah'] as String,
  alamat: json['alamat'] as String,
  telepon: json['telepon'] as String,
  emailOrangTua: json['email_orang_tua'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'no_kk': instance.noKk,
  'nik_ibu': instance.nikIbu,
  'nama_ibu': instance.namaIbu,
  'tempat_lahir_ibu': instance.tempatLahirIbu,
  'tanggal_lahir_ibu': instance.tanggalLahirIbu,
  'gol_darah_ibu': instance.golDarahIbu,
  'nik_ayah': instance.nikAyah,
  'nama_ayah': instance.namaAyah,
  'alamat': instance.alamat,
  'telepon': instance.telepon,
  'email_orang_tua': instance.emailOrangTua,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
