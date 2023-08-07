abstract class IIdentity {
  late int id;
  IIdentity({required this.id});
}

abstract class NamedEntity extends IIdentity {
  late String name;
  NamedEntity({required super.id, required this.name});
}
