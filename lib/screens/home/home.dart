import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();


}
class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> data=[];
@override
  void initState() {
    // TODO: implement initState
  getData();
    super.initState();
  }
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
      body: GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return  Card(
            child: Container(
              child: Column(
                children: [
                  Icon(Icons.note_rounded,size: 100,color: Colors.grey,),
                  Text("${data[index]["name"]}"),
                ],
              ),
            ),
          );
        },
      ),

    );

  }
   getData()async{
     QuerySnapshot response=await FirebaseFirestore.instance.collection("categories").get();
     data.addAll(response.docs);
     setState(() {});
   }


}
