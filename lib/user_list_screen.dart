import 'package:flutter/material.dart';
import 'package:username_id/register_page.dart';
import 'package:username_id/user_model.dart';
import 'database_helper.dart';
import 'main.dart';


class DirectorListScreen extends StatefulWidget {
  final String userName;
  final String password;
  final String dob;
  const DirectorListScreen({super.key,required this.userName,required this.password,required this.dob});


  @override
  State<DirectorListScreen> createState() => _DirectorListScreenState();
}

class _DirectorListScreenState extends State<DirectorListScreen> {
  late List<UserDetailsModel> _userDetailsList;

  @override
  void initState() {

    super.initState();
    getAllDirectorDetails();
  }

  getAllDirectorDetails() async {
    _userDetailsList = <UserDetailsModel>[];
    var userDetailRecords =
    await dbHelper.queryAllRows(DatabaseHelper.registerTable);


    userDetailRecords.forEach((userDetail)
    {
        
        setState(() {
          print(userDetail['_id']);
          print(userDetail['_username']);
          print(userDetail['_password']);
          print(userDetail['_email']);
          print(userDetail['_mobileno']);
          print(userDetail['_dob']);

          var userDetailsModel = UserDetailsModel(
            userDetail['_id'],
            userDetail['_username'],
            userDetail['_password'],
            userDetail['_email'],
            userDetail['_mobileno'],
            userDetail['_dob'],
          );
          print(widget.userName );
          print(userDetail['_username']);
          if (widget.userName == userDetail['_username']){


            _userDetailsList.add(userDetailsModel);
          }




        });

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('User Details'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _userDetailsList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print('---------->Edit or Deleted Invoked : Send Data');
                  print(_userDetailsList[index].id);
                  print(_userDetailsList[index].userName);
                  print(_userDetailsList[index].password);
                  print(_userDetailsList[index].email);
                  print(_userDetailsList[index].mobileno);
                  print(_userDetailsList[index].dob);

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                    settings: RouteSettings(
                      arguments: _userDetailsList[index],
                    ),
                  ));
                },
                child: ListTile(
                  title: Text(_userDetailsList[index].userName!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DOB: ${_userDetailsList[index].dob}'),
                      Text('Email: ${_userDetailsList[index].email}'),
                      Text('Mobile No: ${_userDetailsList[index].mobileno}'),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('--------------> Launch Director Details Form Screen');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegisterScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
