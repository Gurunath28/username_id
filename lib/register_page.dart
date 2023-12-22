import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:username_id/login_page.dart';
import 'database_helper.dart';
import 'main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formField = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var emailController = TextEditingController();
  var _mobilenocontroller = TextEditingController();

  var _dobController = TextEditingController();

  bool passwordToggle = true;

  DateTime? _selectedDate;


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Register'),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formField,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          prefixIcon: Icon(Icons.account_circle),
                          labelText: 'Enter UserName',
                          hintText: 'Enter Your UserName'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter User Name';
                        }
                        ;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _dobController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: 'Enter Date of Birth',
                        hintText: 'Enter Your DOB',
                      ),
                      onTap: () => _selectDate(context),
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Dob';
                        }
                        ;
                      }),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: passwordToggle,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter 6 Digit Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            passwordToggle = !passwordToggle;
                          });
                        },
                        child: Icon(passwordToggle
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter  Password';
                      } else if (_passwordController.text.length < 6) {
                        return 'Password should be min 6 characters';
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Enter Email ID',
                          hintText: 'Enter Your Email ID'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email Id';
                        }
                        ;
                      }),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _mobilenocontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          prefixIcon: Icon(Icons.call),
                          labelText: 'Enter Mobile No',
                          hintText: 'Enter Your Mobile No'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Mobile No';
                        }
                        ;
                      }),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (_formField.currentState!.validate()) {
                        _register();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Successfully Validated')));
                      }

                    },
                    child: Text('Register')),
              ],
            ),
          ),
        )));
   }

  void _register() async {
    print('--------------> _save');
    print('--------------> user Name: ${usernameController.text}');
    print('--------------> Password: ${_passwordController.text}');
    print('--------------> email: ${emailController.text}');
    print('--------------> Mobile no: ${_mobilenocontroller.text}');
    print('--------------> Dob: ${_dobController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.colUserName: usernameController.text,
      DatabaseHelper.colPassword: _passwordController.text,
      DatabaseHelper.colemail: emailController.text,
      DatabaseHelper.colmobileno: _mobilenocontroller.text,
      DatabaseHelper.coldob: _dobController.text,
    };

    final result =
        await dbHelper.insertDirectorDetails(row, DatabaseHelper.registerTable);

    debugPrint('--------> Inserted Row Id: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Saved');
    }
    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
