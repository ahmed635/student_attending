import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:student_attending/config/app_colors.dart';
import 'package:student_attending/providers/center_provider.dart';
import 'package:student_attending/views/screens/center_screen.dart';
import 'package:student_attending/views/widgets/custom_floating_action_button.dart';
import 'package:student_attending/views/widgets/edit_and_delete_buttons.dart';

class CenterListView extends StatefulWidget {
  static String routeName = "/center_list_view";

  const CenterListView({super.key});

  @override
  State<CenterListView> createState() => _CenterListViewState();
}

class _CenterListViewState extends State<CenterListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadCenters();
    });
  }

  _loadCenters() async {
    final provider = Provider.of<CenterProvider>(context, listen: false);
    await provider.loadCentersFromServer();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CenterProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(translate('centers'))),
      body: provider.centers.isEmpty
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: provider.centers.length,
              itemBuilder: (context, index) {
                final center = provider.centers[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      'ID: ${center.id}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text("Name: ${center.name}"),
                        Text("Address: ${center.address}"),
                      ],
                    ),
                    trailing: EditAndDeleteButtons(
                      onDeleteTapped: () => provider.deleteCenter(index),
                      onEditTapped: () => provider.editCenter(context, center),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          CenterScreen.routeName,
        ),
      ),
    );
  }
}
