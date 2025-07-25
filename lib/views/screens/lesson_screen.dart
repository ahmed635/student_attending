import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:student_attending/config/app_colors.dart';
import 'package:student_attending/models/center.dart' as C;
import 'package:student_attending/models/group.dart';
import 'package:student_attending/models/lesson.dart';
import 'package:student_attending/providers/center_provider.dart';
import 'package:student_attending/providers/group_provider.dart';
import 'package:student_attending/providers/lesson_provider.dart';
import 'package:student_attending/utils/object_checker.dart';
import 'package:student_attending/views/widgets/custom_drop_down_menu.dart';
import 'package:student_attending/views/widgets/custom_text_form_field.dart';

class LessonScreen extends StatefulWidget {
  static String routeName = "/lesson_screen";
  Lesson? lesson;

  LessonScreen({super.key, this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final _formKey = GlobalKey<FormState>();
  late Lesson _editLesson;
  List<C.Center> centers = [];
  List<Group> groups = [];

  @override
  void initState() {
    super.initState();
    _editLesson = widget.lesson ?? Lesson();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadGroups();
      await _loadCenters();
      setState(() {});
    });
  }

  _loadGroups() async {
    final provider = Provider.of<GroupProvider>(context, listen: false);
    await provider.loadGroupsFromServer();
    groups = provider.groups;
  }

  _loadCenters() async {
    final provider = Provider.of<CenterProvider>(context, listen: false);
    await provider.loadCentersFromServer();
    centers = provider.centers;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LessonProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lesson == null
              ? translate("add_lesson")
              : translate("edit_lesson"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            children: [
              CustomTextFormField(
                hintText: "search",
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdownMenu<C.Center>(
                      hintText: "Center",
                      selectedItem: _editLesson.center,
                      compareFn: (p0, p1) =>
                          ObjectChecker.areEqual(p0.id, p1.id),
                      items: centers,
                      onChanged: (value) {
                        setState(() {
                          _editLesson.center = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomDropdownMenu<Group>(
                      hintText: "Center",
                      items: groups,
                      selectedItem: _editLesson.group,
                      compareFn: (p0, p1) =>
                          ObjectChecker.areEqual(p0.id, p1.id),
                      onChanged: (value) {
                        setState(() {
                          _editLesson.group = value;
                          // Load students for this group
                        });
                      },
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: DataTable(
                      columnSpacing: 15,
                      horizontalMargin: 30,
                      showBottomBorder: true,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            width: 1,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      headingRowColor:
                          WidgetStateProperty.all(AppColors.primary),
                      columns: [
                        _buildHeaderLabel('Student'),
                        _buildHeaderLabel('ID'),
                        _buildHeaderLabel('Group'),
                        _buildHeaderLabel('Present'),
                      ],
                      rows: provider.students.map((student) {
                        return DataRow(
                          color: WidgetStateProperty.all(AppColors.card),
                          cells: [
                            DataCell(Center(child: Text(student.name!))),
                            DataCell(Center(child: Text(student.id!))),
                            DataCell(Center(child: Text(student.group!))),
                            DataCell(
                              Center(
                                child: Checkbox(
                                  value: student.isPresent(),
                                  onChanged: (value) {
                                    setState(() {
                                      // Update attendance status
                                      // You'll need to implement this in your Student model
                                      // student.setPresent(value ?? false);
                                    });
                                  },
                                ),
                              ),
                            ),
                            // Add more cells for additional columns
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _saveLesson(provider),
                child: Text(
                  widget.lesson == null
                      ? translate("add_lesson")
                      : translate("edit_lesson"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeaderLabel(String? label) {
    return DataColumn(
      label: Text(
        label!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 20,
        ),
      ),
      headingRowAlignment: MainAxisAlignment.center,
    );
  }

  Future<void> _saveLesson(LessonProvider groupProvider) async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.lesson == null) {
          // Add new group
          await groupProvider.addLesson(_editLesson);
        } else {
          // Update existing group
          await groupProvider.updateLesson(_editLesson);
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving group: ${e.toString()}')),
        );
      }
    }
  }
}
