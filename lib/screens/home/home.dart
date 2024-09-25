import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "SignInPage",
                  (route) => false,
                );
              } catch (e) {
                // TODO
                print(e.toString());
              }
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "AddPage");
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onDoubleTap: () => AwesomeDialog(
                    animType: AnimType.rightSlide,
                    context: context,
                    dialogType: DialogType.warning,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      await FirebaseFirestore.instance
                          .collection("categories")
                          .doc(data[index].id)
                          .delete();
                      Navigator.pushReplacementNamed(context, "HomePage");
                    },
                    title: "Warning",
                    desc: "are you sure delete",
                  ).show(),
                  child: Card(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.note_rounded,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Text("${data[index]["name"]}"),
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
    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("categories").get();
    data.addAll(response.docs);
    isLoading = false;
    setState(() {});
  }
}
