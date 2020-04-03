class BarangRiwayat {
  int id;
  String nama;
  int stock;
  int harga;
  String gambar;
  int status;
  int durasi;
  String tanggalTempo;

  BarangRiwayat({this.id, this.stock, this.harga, this.nama, this.gambar, this.durasi, this.status, this.tanggalTempo});

  factory BarangRiwayat.fromJson(Map<String, dynamic> json) {
    return BarangRiwayat(
      id: json['id'],
      nama: json['nama'],
      stock: json['stock'],
      harga: json['harga'],
      gambar: json['gambar'],
      status: json['pivot']['status'],
      durasi: json['pivot']['durasi'],
      tanggalTempo: json['pivot']['tanggal_tempo'],
    );
  }
}
