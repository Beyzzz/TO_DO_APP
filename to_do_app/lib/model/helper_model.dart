final String tableNotes = 'notes';

 class Product {
  static final List<String> values = [
    /// Add all fields
    id, baslik, aciklama, tarih
  ];

  static String id = '_id';
  static String baslik = 'title';
  static String aciklama = 'description';
  static String tarih = 'time';
}

class Note {
  final int? id;
  final String baslik;
  final String aciklama;

  const Note({
    this.id,
    required this.baslik,
    required this.aciklama,
  });

  Note copy({
    int? id,
    String? baslik,
    String? aciklama,
  }) =>
      Note(
        id: id ?? this.id,
        baslik: baslik ?? this.baslik,
        aciklama: aciklama ?? this.aciklama,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[Product.id] as int?,
        baslik: json[Product.baslik] as String,
        aciklama: json[Product.aciklama] as String,
      );

  Map<String, Object?> toJson() => {
        Product.id: id,
        Product.baslik: baslik,
        Product.aciklama: aciklama,
      };
}
/*class Product {
  late int id;
  late String baslik;
  late String aciklama;
  //late String tarih;

  Product({required this.baslik, required this.aciklama});
  Product.withId(
      {required this.id, required this.baslik, required this.aciklama});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baslik = json['baslik'];
    aciklama = json['aciklama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['baslik'] = this.baslik;
    data['aciklama'] = this.aciklama;
    //data["tarih"] = this.tarih;
    return data;
  }
}*/
