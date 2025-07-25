import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:student_attending/models/assistant.dart';
import 'package:student_attending/providers/assistant_provider.dart';
import 'package:student_attending/views/widgets/custom_text_form_field.dart';

class AssistantScreen extends StatefulWidget {
  static String routeName = "/assistant_screen";
  Assistant? assistant;

  AssistantScreen({super.key, this.assistant});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final _formKey = GlobalKey<FormState>();
  late Assistant _editAssistant;

  @override
  void initState() {
    super.initState();
    _editAssistant = widget.assistant ?? Assistant();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssistantProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.assistant == null
              ? translate("add_assistant")
              : translate("edit_assistant"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                hintText: "assistant_name",
                value: _editAssistant.name,
                onChanged: (value) {
                  _editAssistant.name = value!;
                  setState(() {});
                },
                required: true,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                hintText: "assistant_address",
                value: _editAssistant.address,
                onChanged: (value) {
                  _editAssistant.address = value!;
                  setState(() {});
                },
                required: true,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _saveAssistant(provider),
                child: Text(widget.assistant == null
                    ? translate("add_assistant")
                    : translate("edit_assistant")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAssistant(AssistantProvider groupProvider) async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.assistant == null) {
          // Add new group
          await groupProvider.addAssistant(_editAssistant);
        } else {
          // Update existing group
          await groupProvider.updateAssistant(_editAssistant);
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
