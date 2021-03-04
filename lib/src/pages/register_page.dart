import 'package:flutter/material.dart';

import 'package:chat_app/src/pages/widgets/logo.dart';
import 'package:chat_app/src/pages/widgets/labels.dart';
import 'package:chat_app/src/pages/widgets/blue_button.dart';
import 'package:chat_app/src/pages/widgets/custom_input.dart';

import 'package:chat_app/src/routes/app_routes.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * .9,
            margin: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(title: 'Registro'),
                _Form(),
                Labels(
                  title: '¿Ya tienes cuenta?',
                  subtitle: 'Ingresa ahora!',
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, AppRoutes.LOGIN),
                ),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 40.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          CustomInput(
            hintText: 'Nombres',
            controller: nameCtrl,
            prefixIcon: Icon(Icons.account_circle_rounded),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 20.0),
          CustomInput(
            hintText: 'Email',
            controller: emailCtrl,
            prefixIcon: Icon(Icons.mail),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20.0),
          CustomInput(
            obscureText: true,
            hintText: 'Password',
            controller: passCtrl,
            prefixIcon: Icon(Icons.lock),
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 20.0),
          BlueButton(
            child: Text(
              'Registrate',
              style: TextStyle(fontSize: 18.0),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
