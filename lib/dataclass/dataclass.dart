import 'dart:convert';

class ClassUserAuth {
  bool isLoggedIn;
  String kodeUser;
  String kodeGereja;

  ClassUserAuth({
    required this.isLoggedIn,
    required this.kodeUser,
    required this.kodeGereja,
  });

  factory ClassUserAuth.fromJSON(Map<String, dynamic> json) {
    return ClassUserAuth(
      isLoggedIn: json['isLoggedIn'],
      kodeUser: json['kodeUser'],
      kodeGereja: json['kodeGereja'],
    );
  }

  static Map<String, dynamic> toMap(ClassUserAuth userauth) => {
        'isLoggedIn': userauth.isLoggedIn,
        'kodeUser': userauth.kodeUser,
        'kodeGereja': userauth.kodeGereja,
      };

  static String encode(List<ClassUserAuth> userauth) => json.encode(userauth
      .map<Map<String, dynamic>>((e) => ClassUserAuth.toMap(e))
      .toList());

  static List<ClassUserAuth> decode(String userauth) =>
      (json.decode(userauth) as List<dynamic>)
          .map<ClassUserAuth>((e) => ClassUserAuth.fromJSON(e))
          .toList();
}

class ClassUser {
  String kodeUser;
  String kodeGerejaUser;
  String kodeRoleUser;
  String namaUser;
  String ttlUser;
  String jenisKelaminUser;
  String alamatUser;
  String emailUser;
  String noTelpUser;
  String kemampuanUser;
  String imageProfileUser;

  ClassUser(
      {required this.kodeUser,
      required this.kodeGerejaUser,
      required this.kodeRoleUser,
      required this.namaUser,
      required this.ttlUser,
      required this.jenisKelaminUser,
      required this.alamatUser,
      required this.emailUser,
      required this.noTelpUser,
      required this.kemampuanUser,
      required this.imageProfileUser});

  factory ClassUser.fromJSON(Map<String, dynamic> json) {
    return ClassUser(
      kodeUser: json['kode_user'],
      kodeGerejaUser: json['kode_gereja'],
      kodeRoleUser: json['kode_role'],
      namaUser: json['nama_lengkap_user'],
      ttlUser: json['tanggal_lahir_user'],
      jenisKelaminUser: json['jenis_kelamin_user'],
      alamatUser: json['alamat_user'],
      emailUser: json['email_user'],
      noTelpUser: json['no_telp_user'],
      kemampuanUser: json['kemampuan_user'],
      imageProfileUser: json['foto_profile'],
    );
  }
}

class ClassKeuangan {
  String kodeKeuangan;
  String kodeTransaksiKeuangan;
  String kodeSubTransaksiKeuangan;
  String uraianTransaksiKeuangan;
  String tanggalTransaksiKeuangan;
  String jenisTransaksiKeuangan;
  String nominalTransaksiKeuangan;

  ClassKeuangan({
    required this.kodeKeuangan,
    required this.kodeTransaksiKeuangan,
    required this.kodeSubTransaksiKeuangan,
    required this.uraianTransaksiKeuangan,
    required this.tanggalTransaksiKeuangan,
    required this.jenisTransaksiKeuangan,
    required this.nominalTransaksiKeuangan,
  });

  factory ClassKeuangan.fromJSON(Map<String, dynamic> json) {
    return ClassKeuangan(
      kodeKeuangan: json['kodeKeuangan'],
      kodeTransaksiKeuangan: json['kodeTransaksiKeuangan'],
      kodeSubTransaksiKeuangan: json['kodeSubTransaksiKeuangan'],
      uraianTransaksiKeuangan: json['uraianTransaksiKeuangan'],
      tanggalTransaksiKeuangan: json['tanggalTransaksiKeuangan'],
      jenisTransaksiKeuangan: json['jenisTransaksiKeuangan'],
      nominalTransaksiKeuangan: json['nominalTransaksiKeuangan'],
    );
  }
}