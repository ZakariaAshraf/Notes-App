import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.logout_outlined),),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, "AddPage");
      },child: Icon(Icons.add,),),

    );
  }
}
