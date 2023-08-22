// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

import 'package:abgtools/core/iidentity.dart';

List<ArticleModel> articleModelFromJson(String str) => List<ArticleModel>.from(
    json.decode(str).map((x) => ArticleModel.fromJson(x)));

String articleModelToJson(List<ArticleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticleModel extends NamedEntity {
  String nomPiece;
  String codebar;
  String color;
  String refrence;
  dynamic epaisseur;
  dynamic longueur;
  dynamic largeure;
  dynamic surface;
  dynamic electricite;
  dynamic tableCoup;
  dynamic faconnage;
  dynamic lavage;
  dynamic serigraphie;
  dynamic tremp;
  dynamic prixVent;
  dynamic service;
  dynamic trou;
  dynamic prixTrou;
  dynamic cout;
  String? image;
  DateTime createdAt;

  ArticleModel({
    required super.id,
    required this.nomPiece,
    required this.refrence,
    required this.codebar,
    required this.color,
    required this.epaisseur,
    required this.longueur,
    required this.largeure,
    required this.surface,
    required this.electricite,
    required this.tableCoup,
    required this.faconnage,
    required this.lavage,
    required this.serigraphie,
    this.cout,
    this.service,
    this.trou,
    this.prixTrou,
    this.prixVent,
    this.image,
    required this.tremp,
    required this.createdAt,
    required super.name,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: int.parse(json["id"].toString()),
        name: json["nameA"] ?? "Type",
        nomPiece: json["nom_piece"],
        refrence: json["refrence"],
        codebar: json["codebar"],
        color: json["color"],
        epaisseur: json["epaisseur"],
        longueur: json["longueur"],
        largeure: json["largeure"],
        surface: json["surface"],
        electricite: json["electricite"],
        tableCoup: json["table_coup"],
        faconnage: json["faconnage"],
        lavage: json["lavage"],
        serigraphie: json["serigraphie"],
        tremp: json["tremp"],
        cout: json["cout"],
        image: json["image_data"],
        service: json["serviceA"],
        trou: json["trou"] ?? 0,
        prixTrou: json["prixTrou"] ?? 0,
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        prixVent: json["prixVent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameA":name,
        "nom_piece": nomPiece,
        "refrence": refrence,
        "codebar": codebar,
        "color": color,
        "epaisseur": epaisseur,
        "longueur": longueur,
        "largeure": largeure,
        "surface": surface,
        "electricite": electricite,
        "table_coup": tableCoup,
        "faconnage": faconnage,
        "lavage": lavage,
        "serigraphie": serigraphie,
        "tremp": tremp,
        "trou": trou,
        "prixTrou": prixTrou,
        "cout": cout,
        "serviceA": service,
        "prixVent": prixVent,
        "createdAt": createdAt.toIso8601String(),
      };
}
