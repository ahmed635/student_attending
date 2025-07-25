class Group {
  String? id;
  String? name;
  String? center;

  Group({
    this.id,
    this.name,
    this.center,
  });

  @override
  String toString() {
    return 'Group{id: $id, name: $name}';
  }
}
