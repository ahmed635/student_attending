import 'package:flutter/material.dart';
import 'package:student_attending/models/assistant.dart';
import 'package:student_attending/views/screens/assistant_screen.dart';

class AssistantProvider with ChangeNotifier {
  List<Assistant> _assistants = [];
  bool _isLoading = false;
  String? _error;

  List<Assistant> get assistants => _assistants;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadAssistantsFromServer() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));

      _assistants = List.generate(
          8,
          (i) =>
              Assistant(id: "id $i", address: "address $i", name: "name $i"));

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAssistant(Assistant assistant) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Save to database
      await Future.delayed(const Duration(milliseconds: 500));

      _assistants.add(assistant);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAssistant(int index) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Remove from database
      await Future.delayed(const Duration(milliseconds: 500));

      _assistants.removeAt(index);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void editAssistant(BuildContext context, Assistant assistant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssistantScreen(assistant: assistant),
      ),
    );
  }

  // In AssistantProvider class
  Future<void> updateAssistant(Assistant updatedAssistant) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Update in database
      await Future.delayed(const Duration(milliseconds: 500));

      final index = _assistants.indexWhere((g) => g.id == updatedAssistant.id);
      if (index != -1) {
        _assistants[index] = updatedAssistant;
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
