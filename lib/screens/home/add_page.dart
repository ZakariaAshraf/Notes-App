import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
   AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController categoryName = TextEditingController();

   CollectionReference categories = FirebaseFirestore.instance.collection('categories');

   addCategory() async{
     if(categoryName.text!=null){
       try {
         await categories.add({
           "name": categoryName.text,
         });
         Navigator.of(context).pushReplacementNamed("HomePage");
       } catch (e) {
         print("Error"+e.toString());
         // TODO
       }
     }else{
       return;
     }
   }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add category"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: categoryName,
              decoration: InputDecoration(

                label: const Text("Category name"),
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