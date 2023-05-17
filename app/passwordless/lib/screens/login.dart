import "package:flutter/material.dart";
import "package:passwordless/screens/register.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            child: const Text('Login'),
                            onPressed: () async {
                              // String username =
                              //     _username.text.toString().trim();
                              // // encrypt username using publickey from shared prefs
                              // String secret = await key.encryptData(username);
                              // //send the ebcrypted text to server
                              // var res = await api.login(username, secret);
                              //allow user login
                            },
                          )),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("New User ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: const Text("Register "),
                  ),
                  const Text("Here")
                ],
              )
            ],
          ),
        ));
  }
}
