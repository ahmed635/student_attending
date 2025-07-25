import 'package:flutter/material.dart' hide Center;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:student_attending/models/center.dart';
import 'package:student_attending/providers/center_provider.dart';
import 'package:student_attending/views/widgets/custom_text_form_field.dart';

class CenterScreen extends StatefulWidget {
  final Center? center;
  static String routeName = "/center_screen";

  const CenterScreen({super.key, this.center});

  @override
  State<CenterScreen> createState() => _CenterScreenState();
}

class _CenterScreenState extends State<CenterScreen> {
  final _formKey = GlobalKey<FormState>();
  late Center _editCenter;

  @override
  void initState() {
    super.initState();
    _editCenter = widget.center ?? Center();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CenterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.center == null
              ? translate("add_center")
              : translate("edit_center"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                hintText: "center_name",
                value: _editCenter.name,
                onChanged: (value) {
                  _editCenter.name = value!;
                  setState(() {});
                },
                required: true,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                hintText: "center_name",
                value: _editCenter.address,
                onChanged: (value) {
                  _editCenter.address = value!;
                  setState(() {});
                },
                required: true,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _saveCenter(provider),
                child: Text(
                  widget.center == null
                      ? translate("add_center")
                      : translate("edit_center"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveCenter(CenterProvider centerProvider) async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.center == null) {
          // Add new Center
          await centerProvider.addCenter(_editCenter);
        } else {
          // Update existing Center
          await centerProvider.updateCenter(_editCenter);
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving center: ${e.toString()}')),
        );
      }
    }
  }
}
