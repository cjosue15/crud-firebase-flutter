import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.titulo,
    this.valor = 0.0,
    this.imagUrl,
  });

  String id;
  String titulo;
  double valor;
  bool disponible;
  String imagUrl;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        titulo: json["titulo"],
        valor: json["valor"].toDouble(),
        imagUrl: json["imagUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "valor": valor,
        "imagUrl": imagUrl,
      };
}
