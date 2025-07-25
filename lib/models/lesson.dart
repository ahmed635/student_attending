import 'package:student_attending/models/center.dart';
import 'package:student_attending/models/group.dart';
import 'package:student_attending/models/student.dart';

class Lesson {
  String? id;
  DateTime? date;
  Group? group;
  Center? center;
  List<Student>? students;

  Lesson({
    this.id,
    this.date,
    this.group,
    this.center,
    this.students,
  });
}
