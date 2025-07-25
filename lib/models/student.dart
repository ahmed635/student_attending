class Student {
  String? id;
  String? name;
  String? group;
  String? center;
  String? nationalId;
  String? parentName;
  String? phone;

  Student({
    this.id,
    this.name,
    this.group,
    this.center,
    this.nationalId,
    this.parentName,
    this.phone,
  });

  isPresent() {
    return true;
  }
}
