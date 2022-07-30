import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:localhostget/student.dart';

//import 'apicall.g.dart';
import 'name.dart';

void main() {
  runApp(getmethod());
}

class getmethod extends StatelessWidget {
  const getmethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('get form json'),
      debugShowCheckedModeBanner: false,
      home: studentid(),
    );
  }
}

class studentid extends StatefulWidget {
  const studentid({Key? key}) : super(key: key);

  @override
  State<studentid> createState() => _studentidState();
}

class _studentidState extends State<studentid> {
  Future<List<User>>? usersFuture;

  @override
  void initState() {
    super.initState();

//usersFuture = getUsers(context);
  }

  static Future<List<User>> getUsers(BuildContext context) async {
    const url = 'http://192.168.1.89:3000/employee_info';
    final response = await http.get(Uri.parse(url));
//final AssetBundle= DefaultAssetBundle.of(context);
//final data = await AssetBundle.loadString('assets/test.json');
    final body = json.decode(response.body); //data

    return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ListView With JSON'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ), // AppBar

        body: Center(
          child: FutureBuilder<List<User>>(
            future: getUsers(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;

                return buildUsers(users);
              } else {
                return const Text('no user data');
              }
            },
          ),
        ),
      );

  @override
  Widget buildUsers(List<User> users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return Card(
            child: ListTile(
              trailing: Text(user.position),
              title: Text(user.name),
              subtitle: Text(user.id.toString()),
            ),
          );
        },
      );
}