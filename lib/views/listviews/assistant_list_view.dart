import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:student_attending/config/app_colors.dart';
import 'package:student_attending/providers/assistant_provider.dart';
import 'package:student_attending/views/screens/assistant_screen.dart';
import 'package:student_attending/views/widgets/custom_floating_action_button.dart';
import 'package:student_attending/views/widgets/edit_and_delete_buttons.dart';

class AssistantListView extends StatefulWidget {
  static String routeName = "/assistant_list_view";

  @override
  _AssistantListViewState createState() => _AssistantListViewState();
}

class _AssistantListViewState extends State<AssistantListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadAssistants();
    });
  }

  _loadAssistants() async {
    final provider = Provider.of<AssistantProvider>(context, listen: false);
    await provider.loadAssistantsFromServer();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssistantProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(translate('assistants'))),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, AssistantScreen.routeName),
      ),
      body: provider.assistants.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.assistants.length,
              itemBuilder: (context, index) {
                final assistant = provider.assistants[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      'ID: ${assistant.id}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text("Name: ${assistant.name}"),
                        Text("Address: ${assistant.address}"),
                      ],
                    ),
                    trailing: EditAndDeleteButtons(
                      onDeleteTapped: () => provider.deleteAssistant(index),
                      onEditTapped: () =>
                          provider.editAssistant(context, assistant),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
