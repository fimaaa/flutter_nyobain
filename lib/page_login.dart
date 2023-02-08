import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorTextUsername = "";
  String? _errorTextPassword = "";
  String _errorTextLogin = "";

  bool isValidate = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Enter your username',
                errorText: (!isValidate) ? _errorTextUsername : null,
              ),
              controller: usernameController,
            )),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Enter your Password',
                errorText: (!isValidate) ? _errorTextPassword : null,
              ),
              controller: passwordController,
            )),
        Text((!isValidate) ? _errorTextLogin : ""),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(
                  40), // fromHeight use double.infinity as width and 40 is the height
            ),
            onPressed: () {
              if (usernameController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                if (usernameController.text != "1" &&
                    passwordController.text != "1") {
                  setState(() {
                    isValidate = true;
                    _errorTextUsername = null;
                    _errorTextPassword = null;
                    _errorTextLogin = "";
                  });
                  Navigator.of(context).pushReplacementNamed('/data');
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ListDataPage(
                  //             title: "List DataPage",
                  //           )),
                  // );
                  return;
                }
                setState(() {
                  isValidate = false;
                  _errorTextLogin = "Account Not Found";
                });
                return;
              }
              setState(() {
                isValidate = false;
                _errorTextUsername = null;
                _errorTextPassword = null;
              });
              if (usernameController.text.isEmpty) {
                setState(() {
                  _errorTextUsername = "Value Can't Empty";
                });
              }
              if (passwordController.text.isEmpty) {
                setState(() {
                  _errorTextPassword = "Value Can't Empty";
                });
              }
            },
            child: const Text("Login"))
      ]),
      // floatingActionButton: FloatingActionButton(
      //   // When the user presses the button, show an alert dialog containing
      //   // the text that the user has entered into the text field.
      //   onPressed: () {
      //     if (usernameController.text.isNotEmpty &&
      //         passwordController.text.isNotEmpty) {
      //       if (usernameController.text != "1" &&
      //           passwordController.text != "1") {
      //         setState(() {
      //           isValidate = true;
      //           _errorTextUsername = null;
      //           _errorTextPassword = null;
      //         });
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => DataPage(
      //                     title: "DataPage",
      //                   )),
      //         );
      //         return;
      //       }
      //       setState(() {
      //         isValidate = false;
      //         _errorTextUsername = "Account Not Found";
      //         _errorTextPassword = "Account Not Found";
      //       });
      //       return;
      //     }
      //     setState(() {
      //       isValidate = false;
      //       _errorTextUsername = null;
      //       _errorTextPassword = null;
      //     });
      //     if (usernameController.text.isEmpty) {
      //       setState(() {
      //         _errorTextUsername = "Value Can't Empty";
      //       });
      //     }
      //     if (passwordController.text.isEmpty) {
      //       setState(() {
      //         _errorTextPassword = "Value Can't Empty";
      //       });
      //     }
      //   },
      //   tooltip: 'Show me the value!',
      //   child: const Icon(Icons.text_fields),
      // ),
    );
  }
}
