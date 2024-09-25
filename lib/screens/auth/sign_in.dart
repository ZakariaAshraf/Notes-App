import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastering_firebase/screens/auth/sign_up.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In Page"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                const ImageIcon(
                  AssetImage("assets/images/otp.png"),
                  size: 100,
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
                InkWell(
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);
                        AwesomeDialog(
                            animType: AnimType.leftSlide,
                            context: context,
                            dialogType: DialogType.warning,
                            btnOkOnPress: () {},
                            title: "Warning",
                            desc: "we sent you a verification email. ").show();
                      } catch (e) {
                        // TODO
                        print(e.toString());
                      }
                    },
                    child: Container(
                      child: Text(
                        "Forget Password ?",
                        style: TextStyle(
                          color: Colors.deepOrange,
                        ),
                      ),
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.all(10),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        bool isLoading = true;
                        setState(() {});
                        final userSigned = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        isLoading = false;
                        setState(() {});
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "HomePage",
                          (route) => false,
                        );
                      } on FirebaseAuthException catch (e) {
                        // TODO
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
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
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("Don't have an account",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      },
                      child: const Text(
                        "Create!",
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
