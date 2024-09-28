import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastering_firebase/screens/note/note_view.dart';

class AddNote extends StatefulWidget {
  final String noteId;
  AddNote({Key? key, required this.noteId}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController note = TextEditingController();


  addCategory() async{
    CollectionReference notesCollectionRefrence = FirebaseFirestore.instance.collection('categories').doc(widget.noteId).collection("notes");
    if(note.text!=null){
      try {
        await notesCollectionRefrence.add({
          "note": note.text,
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NoteView(noteId:widget.noteId)),);
      } catch (e) {
        print("Error"+e.toString());
        // TODO
      }
    }else{
      return;
    }
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
        title: Text("Add Note"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: note,
              decoration: InputDecoration(

                label: const Text("Note"),
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
              addCategory();
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
                  'Add',
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