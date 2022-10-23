import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import 'database_helper.dart';
import 'register.dart';
 import 'main.dart';


void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login()));
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> _validation() async {
    var result = await DatabaseHelper.compareUser(_usernameController.text, _passwordController.text);

    if(result =="1"){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Home()));
    }else{
      Fluttertoast.showToast(
          msg: "Login failed",
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
        child: Column(mainAxisAlignment: MainAxisAlignment.values[2],
          children: [
            Text(
                "Login",
                style: TextStyle(fontSize: 28),
              ),SizedBox(height: 50,),


            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    label: Text("Username"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor:Colors.lightGreen ,
                    minimumSize: Size.fromHeight(40),shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(20))),
                onPressed: () async {

                  await _validation();

                  _usernameController.text = '';
                  _passwordController.text = '';
                },
                child: Text("Login"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextButton(
                  onPressed: () {

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: const Text("Don't have an account? Sign Up",style: TextStyle(color: Colors.blueGrey),)),
            ),
           ],
        ),
      ),
    );
  }
}