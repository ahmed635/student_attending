import 'package:flutter/material.dart' hide Center;
import 'package:student_attending/models/center.dart';

import '../views/screens/center_screen.dart';

class CenterProvider with ChangeNotifier {
  List<Center> _centers = [];
  bool _isLoading = false;
  String? _error;

  List<Center> get centers => _centers;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadCentersFromServer() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));

      _centers = List.generate(10,
          (i) => Center(id: "id $i", address: "address $i", name: "name $i"));

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCenter(Center center) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Save to database
      await Future.delayed(const Duration(milliseconds: 500));

      _centers.add(center);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCenter(int index) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Remove from database
      await Future.delayed(const Duration(milliseconds: 500));

      _centers.removeAt(index);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void editCenter(BuildContext context, Center center) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CenterScreen(center: center),
      ),
    );
  }

  // In CenterProvider class
  Future<void> updateCenter(Center updatedCenter) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Update in database
      await Future.delayed(const Duration(milliseconds: 500));

      final index = _centers.indexWhere((c) => c.id == updatedCenter.id);
      if (index != -1) {
        _centers[index] = updatedCenter;
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
