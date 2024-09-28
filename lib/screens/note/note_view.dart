import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastering_firebase/screens/home/edit_page.dart';

class NoteView extends StatefulWidget {
  final String categoryId;
  NoteView({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];

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
        title: const Text("Note"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "AddNote");
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onDoubleTap: () => AwesomeDialog(
                    animType: AnimType.rightSlide,
                    context: context,
                    dialogType: DialogType.warning,
                    btnCancelOnPress: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditPage(
                      //         oldName: data[index]["name"],
                      //         docId: data[index].id),
                      //   ),
                      // );
                    },
                    btnCancelText: "Edit",
                    btnOkText: "Delete",
                    btnOkOnPress: () async {
                      // await FirebaseFirestore.instance
                      //     .collection("categories")
                      //     .doc(data[index].id)
                      //     .delete();
                      // Navigator.pushReplacementNamed(context, "HomePage");
                    },
                    title: "Warning",
                    desc: "are you sure delete",
                  ).show(),
                  child: Card(
                    child: Container(
                      child: Column(
                        children: [
                          Text("${data[index]["note"]}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  getData() async {
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection("categories").doc(widget.categoryId).collection("notes")
        .get();
    data.addAll(response.docs);
    isLoading = false;
    setState(() {});
  }
}
