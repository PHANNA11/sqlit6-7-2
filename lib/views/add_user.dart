import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_local_storage/database/database_helper.dart';
import 'package:pro_local_storage/models/user_model.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController textEditingController = TextEditingController();
  File? imageProfile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add User'.toUpperCase(),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              getImageFromCamera();
            },
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          IconButton(
              onPressed: () async {
                getImageFromGallary();
              },
              icon: const Icon(Icons.image))
        ],
      ),
      body: Column(
        children: [
          imageProfile == null
              ? const SizedBox()
              : Image(image: FileImage(File(imageProfile!.path))),
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
                        name: textEditingController.text,
                        profile: imageProfile!.path.toString()))
                    .then((value) => Navigator.pop(context));
              })
        ],
      ),
    );
  }

  void getImageFromCamera() async {
    var fileImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageProfile = File(fileImage!.path);
    });
  }

  void getImageFromGallary() async {
    var fileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageProfile = File(fileImage!.path);
    });
  }
}
