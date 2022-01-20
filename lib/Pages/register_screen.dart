import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_todo/Pages/home_screen.dart';
import 'package:login_todo/model/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final firstNameEditingController =  TextEditingController();
  final secondNameEditingController =  TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController =  TextEditingController();
  final comfirmpasswordEditingController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
       validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Namn kan inte vara kortare än 3 karaktärer");
          }
          if (!regex.hasMatch(value)) {
            return ("Snälla ange ett namn mer än 3 karaktärer");
          }
          return null;
        },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Namn",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
       validator: (value) {
    
          if (value!.isEmpty) {
            return ("Efternamn kan inte vara kortare än 3 karaktärer");
          }
         return null;
        },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Efternamn",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
         validator: (value){
        if (value!.isEmpty) {
          return("Snälla ange ditt Email");
        }
         if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Snälla ange ditt Email");
          }
          return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
       validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key_rounded),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Lösenord",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: comfirmpasswordEditingController,
      obscureText: true,

         validator: (value){
        if (comfirmpasswordEditingController.text.length > 6 && passwordEditingController.text != value) {
          return "Lösenord Matchar inte";
        }
          return null;
      },
      onSaved: (value) {
        comfirmpasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key_rounded),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Upprepa Lösenord",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
           signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          "Signup",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor: Colors.transparent,
       elevation: 0,
       leading: IconButton(
         icon: const Icon(Icons.arrow_back, color: Colors.blue),
         onPressed: (){
           Navigator.of(context).pop();
         },
       ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: Image.asset(
                          "assets/onetek_logo.png",
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(height: 10),
                    firstNameField,
                    const SizedBox(height: 25),
                    secondNameField,
                    const SizedBox(height: 25),
                    emailField,
                    const SizedBox(height: 25),
                    passwordField,
                    const SizedBox(height: 25),
                    confirmPasswordField,
                    const SizedBox(height: 25),
                    signUpButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
    void signUp(String email, String password) async{ 
    if (_formKey.currentState!.validate()) {
  
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {
            postDetailsToFirestore()})
            .catchError((e) 
            {
          Fluttertoast.showToast(msg: e!.message);
        });
    }
}
postDetailsToFirestore() async {
    

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
