import 'dart:convert';
import 'package:formapi/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<User> users = [];
  TextEditingController assetNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Api"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: assetNameController,
              decoration: InputDecoration(
                labelText: 'Asset Name',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: Submit,
            child: Text('Submit'),
          ),
          SizedBox(height: 10,width: 15),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                Color backgroundColor = user.success == '0' ? Colors.red : Colors.green;
                return ListTile(
                  tileColor: backgroundColor,
                  title: Text(user.message, style: TextStyle(color: Colors.white)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Submit() {
    print("Submitting...");

    Map data = {
      'mobile_number': '8082019432',
      'yard_id': '3',
      'assetname': assetNameController.text,
    };

    const url = 'https://rymsindia.com/app/addYardAsset.php';
    final uri = Uri.parse(url);

    http.post(uri, body: data).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final parsedResponse = json.decode(response.body);

        if (parsedResponse is List) {
          final usersList = parsedResponse.map((data) => User.fromJson(data)).toList();

          setState(() {
            users = usersList;
          });
        }
      }
    });

    print("Submit function completed.");
  }
}
