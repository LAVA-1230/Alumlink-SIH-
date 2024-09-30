import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alumni_app_1/components/my_button.dart';
import 'package:alumni_app_1/components/my_textfield.dart';
// import 'package:alumni_app_1/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  final fullnamecontooler=TextEditingController();
  final phonenocontoller=TextEditingController();
  final entrynumbercontoller=TextEditingController();
  // sign user in method
  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if(passwordController.text.toString()==confirmpasswordController.text.toString()){
        UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);

        FirebaseFirestore.instance.collection('users').doc(userCredential.user!.email).set({
          'full name': fullnamecontooler,
          'email id':usernameController,
          'phoneNo': phonenocontoller,
          'entry number':entrynumbercontoller,
        });
        // adduserdetail(fullnamecontooler.text.toString(), usernameController.text.toString(), int.parse(phonenocontoller.text.trim()),entrynumbercontoller.text.toString());
      }

      else{
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password Don\'t match!!'),
            );
          });
      }
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  // Future adduserdetail(String firstname, String email,int phoneno,String entryno) async{
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'full name': firstname,
  //     'email id':email,
  //     'phoneNo': phoneno,
  //     'entry number':entryno
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
            
                //'Let\'s create an account for you'
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // username textfield
                MyTextField(
                  controller:fullnamecontooler,
                  hintText: 'Full Name',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
                // password textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Email Id',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10), 

                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),  

                const SizedBox(height: 10),

                MyTextField(
                  controller: phonenocontoller,
                  hintText: 'Phone Number',
                  obscureText: false,
                ), 

                const SizedBox(height: 10,),

                MyTextField(
                  controller: entrynumbercontoller,
                  hintText: 'Entry Number',
                  obscureText: false,
                ), 

                 

                const SizedBox(height: 10,),
                          
            
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // sign in button
                MyButton(
                  
                  onTap: signUserIn,
                  text: "Sign up",
                ),
            
                const SizedBox(height: 50),
            
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 50),
            
                // google + apple sign in buttons
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // google button
                //     SquareTile(imagePath: 'lib/images/google.png'),
            
                //     SizedBox(width: 25),
            
                //     // apple button
                //     SquareTile(imagePath: 'lib/images/apple.png')
                //   ],
                // ),
            
                const SizedBox(height: 50),
            
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}