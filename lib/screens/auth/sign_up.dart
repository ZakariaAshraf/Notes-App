import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastering_firebase/screens/auth/sign_in.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In Page"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const ImageIcon(
            AssetImage("assets/images/otp.png"),
            size: 100,
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: const Text("Name"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              label: const Text("Email"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                label: const Text("Password"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    )),
              )),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: GestureDetector(
              onTap: ()async{
                try {
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil("HomePage", (route) => false,);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }

              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.redAccent,
                ),
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
