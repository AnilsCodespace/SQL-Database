import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database_helper.dart';

import 'login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Register(),));
}

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> _addItem() async {
    var result =  await DatabaseHelper.createUser(_usernameController.text, _emailController.text, _passwordController.text);
    if(result!=null) {
      Fluttertoast.showToast(
          msg: "Saved Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Login()));
    }else{
      Fluttertoast.showToast(
          msg: "Registration failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 70, 30, 30),
              child: Text(
                "Sign up",
                style: TextStyle(fontSize: 28),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    label: Text("Username"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Enter Username"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Enter  Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextField(
                controller: _passwordController,
                obscuringCharacter: '*',
                obscureText: true,
                decoration: InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Enter Password"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextField(
                obscuringCharacter: '*',
                obscureText: true,
                decoration: InputDecoration(
                    label: Text("Confirm Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Enter Confirm Password"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen,shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(20)),
                    minimumSize: Size.fromHeight(40)),
                onPressed: () async {
                  // Save new journal
                  await _addItem();
                  // Clear the text fields
                  _usernameController.text = '';
                  _emailController.text = '';
                  _passwordController.text = '';
                },
                child: Text("Sign Up"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text("Have an account? Login")),
            ),
          ],
        ),
      ),
    );
  }
}