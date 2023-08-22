class EnvrinementModel {
  EnvrinementModel({
    required this.token,
    required this.type,
  });

  String token;
  int type;

  factory EnvrinementModel.fromMap(Map<String, dynamic> json) =>
      EnvrinementModel(
        token: json["token"],
        type: int.parse(json["type"].toString()),
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "type": type,
      };
}
