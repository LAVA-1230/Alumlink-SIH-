import 'package:alumni_app_1/pages/textbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}



class _ProfilePageState extends State<ProfilePage> {
  final currentuser=FirebaseAuth.instance.currentUser!;
  final usercollection=FirebaseFirestore.instance.collection('users');

  Future<void> editfield(String field ) async{
    String new_field="";
    await showDialog(context: context, builder: (context)=>AlertDialog(backgroundColor:Colors.grey[900],title:  Text("Edit$field",style: TextStyle(color: Colors.white),),
    content: TextField(autofocus: true,style:TextStyle(color: Colors.white),decoration: InputDecoration(hintText: "Enter new$field",hintStyle: TextStyle(color: Colors.grey)),onChanged: (value){
      new_field=value;
    },),
    actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel",style: TextStyle(color: Colors.white),)),
    TextButton(onPressed: ()=>Navigator.of(context).pop(new_field), child: Text("Save",style: TextStyle(color: Colors.white),))],));

    if(new_field.trim().length>0){

      await usercollection.doc(currentuser.email).update({field:new_field});
    }

    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.grey[900],
      ),
      body: StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('users').doc(currentuser.email).snapshots(), builder: (context, snapshot){
        if(snapshot.hasData){
          final userdata=snapshot.data!.data() as Map<String,dynamic>;
          return  ListView(children: [

        const SizedBox(height: 10,),
        
        // implement logic to add image from gallery and save it to flutter firebase (For now I am just putting an Icon on it)
        Icon(Icons.person,size: 72,),

        const SizedBox(height: 10,),

        Text(currentuser.email!,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700]),),

        Padding(padding: const EdgeInsets.only(left: 25.0),
        child: Text('My Details',style: TextStyle(color: Colors.grey[600]),),
        ),

        MyTextBox(sectionName: 'Full Name', text: userdata['full name'], onPressed: () =>editfield('full name'),),

        MyTextBox(sectionName: 'Entry No.', text: userdata['entry number'], onPressed: () =>editfield('entry number'),),

        // MyTextBox(sectionName: 'username', text: 'lava', onPressed: () =>editfield('username'),),
      ],);
        } else if(snapshot.hasError){
          return Center(child: Text('Error${snapshot.hasError}'),);
        }
        return const Center(child: CircularProgressIndicator(),);
      })
    );
  }
}