import 'package:flutter/material.dart';
import 'package:pro_local_storage/database/database_helper.dart';
import 'package:pro_local_storage/models/user_model.dart';
import 'package:pro_local_storage/views/add_user.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({Key? key}) : super(key: key);

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  Future<List<UserModel>>? listusers;
  late DatabaseHelper db;
  getRefresh() {
    db = DatabaseHelper();
    setState(() {
      listusers = db.getUserData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            onPressed: () {
              getRefresh();
            },
          ),
          title: Text('List User'.toUpperCase())),
      body: FutureBuilder(
        future: listusers,
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Icon(
                Icons.info,
                color: Colors.red,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var user = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Text(user.name.toString()),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUser(),
                ));
          },
          child: const Icon(Icons.add)),
    );
  }
}
