import 'dart:convert';
import 'package:checkin_application/myconfig.dart';
import 'package:checkin_application/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late double screenHeight, screenWidth, cardwitdh;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();

  bool _passwordVisible = true;

  String selectedDept = "Department";
  List<String> deptlist = [
    "Department",
    "Human Resources",
    "Finance and Accounting",
    "Sales and Marketing",
    "Information Technology",
    "Customer Service",
    "Research and Development",
    "Production and Manufacturing",
    "Supply Chain and Logistics",
    "Administration and Support",
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 32.0, right: 16.0, left: 30.0, bottom: 32.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),

                    //////////// "Name"
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 24.0, left: 24.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: _nameEditingController,
                        validator: (val) => val!.isEmpty || (val.length < 5)
                            ? "name must be longer than 5"
                            : null,
                        style: const TextStyle(fontSize: 14.0),
                        decoration: InputDecoration(
                          hintText: 'Name',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                        ),
                      ),
                    ),

                    /////"Department"
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 24.0, left: 24.0),
                      child: DropdownButtonFormField(
                        decoration: buildInputDecoration('Department'),
                        value: selectedDept,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDept = newValue!;
                            print(selectedDept);
                          });
                        },
                        items: deptlist.map((selectedDept) {
                          return DropdownMenuItem(
                            value: selectedDept,
                            child: Text(
                              selectedDept,
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    ////
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 24.0, left: 24.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (val) => val!.isEmpty || (val.length < 10)
                            ? "phone must be longer or equal than 10"
                            : null,
                        controller: _phoneEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontSize: 14.0),
                        decoration: buildInputDecoration('Phone No'),
                      ),
                    ),

                    //////////// "Email"
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 24.0, left: 24.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.next,
                        controller: _emailEditingController,
                        validator: (val) => val!.isEmpty ||
                                !val.contains("@") ||
                                !val.contains(".")
                            ? "enter a valid email"
                            : null,
                        style: const TextStyle(fontSize: 14.0),
                        keyboardType: TextInputType.emailAddress,
                        decoration: buildInputDecoration('Email Address'),
                      ),
                    ),

                    ////////password
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 24.0, left: 24.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: _passEditingController,
                        validator: (val) => val!.isEmpty || (val.length < 5)
                            ? "password must be longer than 5"
                            : null,
                        obscureText: true,
                        style: const TextStyle(fontSize: 14.0),
                        decoration: buildInputDecoration('Password'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 24.0, left: 24.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: _pass2EditingController,
                        validator: (val) => val!.isEmpty || (val.length < 5)
                            ? "password must be longer than 5"
                            : null,
                        obscureText: true,
                        style: const TextStyle(fontSize: 14.0),
                        decoration: buildInputDecoration('Confirm Password'),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 40.0, left: 40.0, top: 40),
                          child: ElevatedButton(
                            onPressed: onSignUpDialog,
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(25.0),
                                // side: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.lightBlue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  void onSignUpDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your input")));
      return;
    }
    String passa = _passEditingController.text;
    String passb = _pass2EditingController.text;
    if (passa != passb) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your password")));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Sign up new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                signupUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void signupUser() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("Please Wait"),
          content: Text("Signing up..."),
        );
      },
    );
    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String phone = _phoneEditingController.text;
    String passa = _passEditingController.text;

    http.post(
        Uri.parse("${MyConfig().SERVER}/checkin_app/php/signup_employee.php"),
        body: {
          "name": name,
          "dept": selectedDept,
          "email": email,
          "phone": phone,
          "password": passa,
        }).then((response) {
      print(response.body);
      print(response.statusCode);

      var jsondata = jsonDecode(response.body);
      print(jsondata);

      //var jsondata= json.decode(json.encode(response.body));

      // if (response.statusCode == 200 && jsondata['status'] == 'success') {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("Sign Up Success")));
      //   Navigator.pop(context);
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (content) => LoginScreen()));
      // } else {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("Sign Up Failed")));
      //   Navigator.pop(context);
      // }

      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Success")));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const LoginScreen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Failed")));
          Navigator.pop(context);
        }
        // Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registration Failed")));
        Navigator.pop(context);
      }
    });
  }
}
