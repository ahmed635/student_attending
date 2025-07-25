import 'package:flutter/material.dart' hide Center;
import 'package:student_attending/models/center.dart';
import 'package:student_attending/models/group.dart';
import 'package:student_attending/models/student.dart';
import 'package:student_attending/views/screens/lesson_screen.dart';

import '../models/lesson.dart';

class LessonProvider with ChangeNotifier {
  List<Lesson> _lessons = [];
  List<Student> _students = [];
  bool _isLoading = false;
  String? _error;

  List<Lesson> get lessons => _lessons;

  bool get isLoading => _isLoading;

  List<Student> get students => _students;

  String? get error => _error;

  Future<void> loadLessonsFromServer() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));
      _students = List.generate(
          8,
          (i) => Student(
                id: "s_$i",
                name: "name__$i",
                center: "center",
                group: "group",
                nationalId: "national",
                parentName: "parent",
                phone: "44444444",
              ));

      _lessons = List.generate(
          8,
          (i) => Lesson(
              id: "id $i",
              group: Group(id: "$i", name: "group $i"),
              center: Center(id: "$i", name: "center $i"),
              students: _students));

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addLesson(Lesson lesson) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Save to database
      await Future.delayed(const Duration(milliseconds: 500));

      _lessons.add(lesson);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteLesson(int index) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Remove from database
      await Future.delayed(const Duration(milliseconds: 500));

      _lessons.removeAt(index);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void editLesson(BuildContext context, Lesson lesson) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonScreen(lesson: lesson),
      ),
    );
  }

  // In LessonProvider class
  Future<void> updateLesson(Lesson updatedLesson) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Update in database
      await Future.delayed(const Duration(milliseconds: 500));

      final index = _lessons.indexWhere((g) => g.id == updatedLesson.id);
      if (index != -1) {
        _lessons[index] = updatedLesson;
      }

      _error = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
