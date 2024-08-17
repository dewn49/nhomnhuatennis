import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// showCreateTodoModal function
Future<void> showCreateUserModal(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const CreateMemberModal();
    },
  );
}

class CreateMemberModal extends StatefulWidget {
  const CreateMemberModal({super.key});

  static String state = "create_member";

  @override
  createState() => _CreateMemberState();
}

class _CreateMemberState extends NyState<CreateMemberModal> {
  _CreateMemberState() {
    stateName = CreateMemberModal.state;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  bool isSupabaseLoading = false;

  @override
  init() async {}

  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(CreateMemberModal.state, data: "example payload");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isSupabaseLoading = true;
              });
              try {
                await Supabase.instance.client.from('nn_member').insert({
                  'name': _nameController.text,
                  'meta': '{}',
                });
                if (context.mounted) Navigator.of(context).pop();
                showToastSuccess(
                    description:
                        "Thành công thêm thành viên.Logout để cập nhật");
              } catch (e) {
                Navigator.of(context).pop();
                if (context.mounted)
                  showToastOops(description: "Lỗi thêm thành viên. Thử lại");
              }
              setState(() {
                isSupabaseLoading = false;
              });
            }
          },
          child: isSupabaseLoading
              ? const CircularProgressIndicator()
              : const Text('Create'),
        ),
      ],
    );
  }
}
