import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app_assignment/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  AuthController loginController = Get.put(AuthController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _obsecurePassword.dispose();
  }

  bool? islaoding;
  bool isprocesscomplete = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.5),
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: loginController.emailIDController,
                            showCursor: true,
                            style: const TextStyle(fontSize: 13),
                            validator: (String? value) {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value!))
                                return 'Please Enter Valid Email';
                              else
                                return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF666666),
                              ),
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                  color: Color(0xFF666666), fontSize: 13),
                              hintText: "Email",
                            ),
                          ),
                          ValueListenableBuilder(
                              valueListenable: _obsecurePassword,
                              builder: (context, value, child) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 25,
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 13),
                                    showCursor: true,
                                    controller:
                                        loginController.passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: _obsecurePassword.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Password";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Color(0xFF666666),
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            _obsecurePassword.value =
                                                !_obsecurePassword.value;
                                          },
                                          icon: _obsecurePassword.value
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off)),
                                      fillColor: const Color(0xFFF2F3F5),
                                      hintStyle: const TextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 13),
                                      hintText: "Password",
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      //Api call
                                      loginController.login();

                                      print("Api Hit");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: primaryColor),
                                  child: const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 15),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
