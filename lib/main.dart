import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DataFromApi(),
    );
  }
}

class DataFromApi extends StatefulWidget {
  const DataFromApi({Key? key}) : super(key: key);

  @override
  _DataFromApiState createState() => _DataFromApiState();
}

class _DataFromApiState extends State<DataFromApi> {
  getUserData() async {
    var response =
        await http.get(Uri.http("jsonplaceholder.typicode.com", "users"));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(u['name'], u['email'], u['username']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("UserData"),
        ),
        body: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                const Center(
                  child: Text("Loading..."),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: snapshot.data[i].name,
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}

class User {
  final String name, email, userName;
  User(this.name, this.email, this.userName);
}
