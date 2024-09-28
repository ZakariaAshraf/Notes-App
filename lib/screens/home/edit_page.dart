import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String oldName;
  final String docId;
   EditPage({Key? key, required this.oldName, required this.docId}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController categoryName = TextEditingController();

   CollectionReference categories = FirebaseFirestore.instance.collection('categories');

   updateCategory() async{
     if(categoryName.text!=null){
       try {
         await categories.doc(widget.docId).update({"name": categoryName.text,});
         Navigator.of(context).pushNamedAndRemoveUntil("HomePage",(route) =>false,);
       } catch (e) {
         print("Error"+e.toString());
         // TODO
       }
     }else{
       return;
     }
   }
   @override
  void initState() {
    // TODO: implement initState
     categoryName.text=widget.oldName;
      super.initState();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    categoryName.dispose();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: categoryName,
              decoration: InputDecoration(

                label: const Text("name"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    )),
              ),
            ),
          ),
          const SizedBox(height: 30,),
          InkWell(
            onTap: (){
              updateCategory();
            },
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.redAccent,
              ),
              child: const Center(
                child: Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],

      ),
    );
  }
}