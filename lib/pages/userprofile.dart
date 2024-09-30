import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'textbox.dart';
import 'utils.dart';   
import 'package:image_picker/image_picker.dart';

// class UserService {
//   Future<Map<String, dynamic>?> getCurrentUserDetails() async {
//     // Get the current logged-in user
//     User? firebaseUser = FirebaseAuth.instance.currentUser;

//     if (firebaseUser != null) {
//       try {
//         // Fetch user document from Firestore using the user's UID
//         DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
//             .instance
//             .collection('users')
//             .doc(firebaseUser.uid)
//             .get();

//         // Return the user's data if it exists
//         return userDoc.data();
//       } catch (e) {
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
// }


class UserService {
  Future<Map<String, dynamic>?> getCurrentUserDetails() async {
    // Get the current logged-in user
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    // Check if a user is logged in
    if (firebaseUser == null) {
      print("No user is logged in.");
      return null;
    }

    try {
      // Fetch user document from Firestore using the user's UID
      DocumentReference<Map<String, dynamic>> userDocRef = FirebaseFirestore
          .instance
          .collection('users')
          .doc(firebaseUser.uid);

      // Get the document snapshot
      DocumentSnapshot<Map<String, dynamic>> userDoc = await userDocRef.get();

      // Check if the document exists
      if (!userDoc.exists) {
        print("User document not found in Firestore for UID: ${firebaseUser.uid}");
        return null;
      }

      // Return the user's data if it exists
      Map<String, dynamic>? userData = userDoc.data();
      if (userData == null) {
        print("User document is empty.");
        return null;
      }

      return userData;
    } catch (e) {
      print("Error fetching user details: $e");
      return null;
    }
  }
}



class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserService _userService = UserService();
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<void> _fetchUserDetails() async {
    try {
      Map<String, dynamic>? userData =
          await _userService.getCurrentUserDetails();
      if (userData != null) {
        setState(() {
          _userData = userData;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'This is our Profile Page , where we will Show User Detail Based on the type of User (Either Alumni and)';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load user data: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> editfield(String field) async {
    User? user = FirebaseAuth.instance.currentUser;
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text(
                "Edit $field",
                style: TextStyle(color: Colors.white),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ));

    if (newValue.trim().length > 0) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({field: newValue});
    }

    // if (user != null) {
    //   try {
    //     if (field == "Full Name") {
    //       user.updateDisplayName(newValue);
    //     }
    //     if (field == "Email Id") {
    //       user.verifyBeforeUpdateEmail(newValue);
    //     }
    //     // if(field=="Mobile Number"){
    //     //   user.updatePhoneNumber(newValue);
    //     // }
    //   } catch (e) {
    //     showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             content: Text(e.toString()),
    //           );
    //         });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.grey[900],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _userData != null
                  ? ListView(
                      padding: EdgeInsets.all(16.0),
                      children: [
                        const SizedBox(
                          height: 50,
                        ),

                        Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://static.vecteezy.com/system/resources/previews/018/765/757/original/user-profile-icon-in-flat-style-member-avatar-illustration-on-isolated-background-human-permission-sign-business-concept-vector.jpg'),
                                  ),
                            Positioned(
                              child: IconButton(
                                  onPressed: selectImage,
                                  icon: Icon(Icons.add_a_photo)),
                              bottom: -10,
                              left: 80,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 50,
                        ),


                        if (_userData != null) ...[
                          MyTextBox(
                            sectionName: "full name",
                            text: "${_userData!['full name']}",
                            onPressed: () => editfield("full name"),
                          ),
                          MyTextBox(
                            sectionName: "email id",
                            text: "${_userData!['email id']}",
                            onPressed: () => editfield('email id'),
                          ),
                          MyTextBox(
                            sectionName: "mobile number",
                            text: "${_userData!['phoneNo']}",
                            onPressed: () {},
                          ),
                        ],

                        // if(_userData !=null){
                        //   MyTextBox(
                        //     sectionName: "full name",
                        //     text: "${_userData!['full name']}",
                        //     onPressed: () => editfield("full name")),

                        //   MyTextBox(
                        //     sectionName: "email id",
                        //     text: "${_userData!['email id']}",
                        //     onPressed: () => editfield('email id')),

                        //   MyTextBox(
                        //     sectionName: "mobile number",
                        //     text: "${_userData!['phoneNo']}",
                        //     onPressed: () {}),
                        // }

                        // Text('Email: ${_userData!['email id']}'),
                        // Text('UID: ${_userData!['uid']}'),
                        // Text('Full Name: ${_userData!['full name']}'),
                        // Text('Mobile No.: ${_userData!['phoneNo']}')
                      ],
                    )
                  : Center(child: Text('No user data available.')),
    );
  }
}
