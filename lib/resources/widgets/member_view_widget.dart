import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/posts.dart';
import 'package:flutter_app/config/decoders.dart';
import 'package:flutter_app/resources/widgets/create_member_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> showUpdateMemberModal(
    BuildContext context, Member selectedMember) async {
  await showDialog(
    context: context,
    builder: (context) {
      return MemberView(member: selectedMember);
    },
  );
}

class MemberView extends StatefulWidget {
  const MemberView({required this.member, super.key});

  static String state = "member_view";
  final Member member;

  @override
  createState() => _MemberViewState();
}

class _MemberViewState extends NyState<MemberView> {
  _MemberViewState() {
    stateName = MemberView.state;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  int isSupabaseLoading = 0; // =1 : update progress, =2 : remove progress
  static int NN_MEMBER_UPDATE = 1;
  static int NN_MEMBER_REMOVE = 2;

  @override
  init() async {}

  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(MemberView.state, data: "example payload");
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.member.name!;
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
            if (widget.member.id! <= 24) {
              showToastInfo(description: "Thành viên VIP ko thể xóa");
              return;
            }
            if (_formKey.currentState!.validate()) {
              setState(() {
                isSupabaseLoading = NN_MEMBER_REMOVE;
              });
              try {
                await Supabase.instance.client
                    .from('nn_member')
                    .delete()
                    .eq('id', widget.member.id.toString())
                    .select();
                if (context.mounted) Navigator.of(context).pop();
                showToastSuccess(
                    description:
                        "Thành công xóa thành viên.Logout để cập nhật");
              } catch (e) {
                Navigator.of(context).pop();
                if (context.mounted)
                  showToastOops(
                      description: "Lỗi cập nhật thành viên. Thử lại");
              }
              setState(() {
                isSupabaseLoading = 0;
              });
            }
          },
          child: isSupabaseLoading == NN_MEMBER_REMOVE
              ? const CircularProgressIndicator()
              : const Text('Xóa'),
        ),
        TextButton(
          onPressed: () async {
            if (widget.member.id! <= 24) {
              showToastInfo(description: "Thành viên VIP ko thể thay đổi");
              return;
            }

            if (_formKey.currentState!.validate()) {
              setState(() {
                isSupabaseLoading = NN_MEMBER_UPDATE;
              });
              try {
                await Supabase.instance.client
                    .from('nn_member')
                    .update({
                      'name': _nameController.text,
                      'meta': '{}',
                    })
                    .eq('id', widget.member.id.toString())
                    .select();
                if (context.mounted) Navigator.of(context).pop();
                showToastSuccess(
                    description:
                        "Thành công cập nhật thành viên.Logout để cập nhật");
              } catch (e) {
                Navigator.of(context).pop();
                if (context.mounted)
                  showToastOops(
                      description: "Lỗi cập nhật thành viên. Thử lại");
              }
              setState(() {
                isSupabaseLoading = 0;
              });
            }
          },
          child: isSupabaseLoading == NN_MEMBER_UPDATE
              ? const CircularProgressIndicator()
              : const Text('Lưu'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            showCreateUserModal(context);
          },
          child: const Text('Thêm'),
        ),
      ],
    );
  }
}
