class Center {
  String? id;
  String? name;
  String? address;

  Center({this.id, this.name, this.address});

  @override
  String toString() {
    return 'Center{id: $id, name: $name}';
  }
}