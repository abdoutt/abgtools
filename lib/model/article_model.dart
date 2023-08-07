// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

import 'package:abgtools/core/iidentity.dart';

List<ArticleModel> articleModelFromJson(String str) => List<ArticleModel>.from(json.decode(str).map((x) => ArticleModel.fromJson(x)));

String articleModelToJson(List<ArticleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
        required this.tremp, required super.name,
    });

    factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: int.parse(json["id"].toString()),
        name: json["name"]??"",
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
    );

    Map<String, dynamic> toJson() => {
        "id": id,
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
    };
}
