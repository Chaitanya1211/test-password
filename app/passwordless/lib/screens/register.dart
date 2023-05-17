import 'package:flutter/material.dart';

import '../api/api.dart';
import '../helper/alert.dart';
import '../safe/keys.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  Api apiCall = Api();
  Alert alert = Alert();
  Keys key = Keys();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: TextFormField(
                  controller: _username,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Enter Username',
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      var response = await apiCall
                          .checkAvailability(_username.text.trim());
                      print(response);
                      if (response == "user exists") {
                        //check for user exists
                        alert.showMyDialog(context, "Username already exixts",
                            "The username already exists. Please try again with different username");
                      } else {
                        //if user does not exists. Create new user
                        List<String> result = key.generateRSAKeyPair(2048);
                        final publicKey = result[0];
                        final privateKey = result[1];
                        print("Public Key" + publicKey);
                        print("Private Key" + privateKey);
                        // var registerResponse = await apiCall
                        //     .registerUser(_username.text.trim().toString());
                        // if (registerResponse["message"] ==
                        //     "User Registered Successfully") {
                        //   shared.setPublicKey(registerResponse["publicKey"]);
                        //   String pub = await shared.getPublicKey();
                        //   print("Public Key from Shared prefs : $pub");
                        //   alert.showMyDialog(
                        //       context,
                        //       "User Registration Successfull",
                        //       "You have registered successfully.");

                        // } else {
                        //   alert.showMyDialog(
                        //       context,
                        //       "User Registration Unsuccessfull",
                        //       "Registration unsuccessfull. Please try again later");
                        // }
                        // print(registerResponse);
                      }
                    },
                  )),
            ],
          )),
    );
  }
}
