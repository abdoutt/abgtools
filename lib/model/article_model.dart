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
  double epaisseur;
  double longueur;
  double largeure;
  double surface;
  double electricite;
  double tableCoup;
  double faconnage;
  double lavage;
  double serigraphie;
  double tremp;
  double prixVent;
  double service;
  int trou;
  double prixTrou;
  double cout;
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
    required this.cout,
    required this.service,
    required this.trou,
    required this.prixTrou,
    required this.prixVent,
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
        epaisseur: double.parse(json["epaisseur"].toString()),
        longueur: double.parse(json["longueur"].toString()),
        largeure: double.parse(json["largeure"].toString()),
        surface: double.parse(json["surface"].toString()),
        electricite: double.parse(json["electricite"].toString()),
        tableCoup: double.parse(json["table_coup"].toString()),
        faconnage: double.parse(json["faconnage"].toString()),
        lavage: double.parse(json["lavage"].toString()),
        serigraphie: double.parse(json["serigraphie"].toString()),
        tremp: double.parse(json["tremp"].toString()),
        cout: double.parse(json["cout"].toString()),
        service: double.parse(json["serviceA"].toString()),
        trou: int.parse(json["trou"].toString()),
        prixTrou: double.parse(json["prixTrou"].toString()),
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"].toString()),
        prixVent: double.parse(json["prixVent"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameA": name,
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
