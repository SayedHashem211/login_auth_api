import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../api_helper/dio_helper.dart';
import '../api_helper/end_points.dart';
import '../components/show_toast.dart';
import '../constants.dart';
import '../screens/tasks_screem.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2B475E),
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                    radius: 100,
                    child:
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('Images/login.jpg'),
                    )
                ),
                Text('Login Page',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'pacifico'
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200,vertical: 40),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please, Enter your Email';
                      }else if(value.contains('@gmail.com')){
                        return 'PLease, Enter a Valid Email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username',
                    ),
                  ),
                ),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200,vertical: 30),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please, Enter your Password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your password',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text('Forgot Password',),
                ),
                SizedBox(height: 30,),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          print('Go Login');
                          DioHelper.postData(endPoint: login, query: {
                            'email' : emailController.text,
                            'password' : passwordController.text,
                          }).then((value){
                            // print(value.data);
                            token = value.data['authorisation']['token'];
                            showToast(message: 'Login Successfully');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TasksScreen()));
                            print(token);
                          }).catchError((error){
                            print('Login Error Here ${error.response.data}');
                            showToast(message: error.response.data['message']);
                          });
                        }
                      },
                    )
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}