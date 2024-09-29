import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final String oldNote;
  final String docId;
  final String noteId;
  EditNote({Key? key, required this.oldNote, required this.docId, required this.noteId}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController note = TextEditingController();


  updateCategory() async{
    CollectionReference notes =  FirebaseFirestore.instance.collection('categories').doc(widget.docId).collection("notes");
    if(note.text!=null){
      try {
        await notes.doc(widget.noteId).update({"note": note.text,});
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
    note.text=widget.oldNote;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    note.dispose();
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
              controller: note,
              decoration: InputDecoration(

                label: const Text("note"),
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