import 'package:flutter/material.dart';
import 'package:pro_local_storage/views/list_user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListUserScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  getRefData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('number') ?? 0;
      print(counter);
    });
  }

  setRefData() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt('number', ++counter);
    print(counter);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRefData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () async {
              var prefs = await SharedPreferences.getInstance();
              setState(() {
                counter = prefs.getInt('number') ?? 0;
                print(counter);
              });
            },
            tooltip: 'refresh',
            child: const Icon(Icons.refresh),
          ),
          FloatingActionButton(
            onPressed: () async {
              setState(() {
                setRefData();
              });
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void merGList() {
    List<String> list1 = ['sa', 'lin', 'chivern'];
    list1.add('value');
  }
}
