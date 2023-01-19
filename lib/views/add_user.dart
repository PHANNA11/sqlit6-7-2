import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_local_storage/database/database_helper.dart';
import 'package:pro_local_storage/models/user_model.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add User'.toUpperCase(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                  hintText: 'Enter name', border: OutlineInputBorder()),
            ),
          ),
          CupertinoButton(
              color: Theme.of(context).primaryColor,
              child: const Text('save'),
              onPressed: () async {
                await DatabaseHelper()
                    .insertData(UserModel(
                        id: DateTime.now().microsecond,
                        name: textEditingController.text))
                    .then((value) => Navigator.pop(context));
              })
        ],
      ),
    );
  }
}
