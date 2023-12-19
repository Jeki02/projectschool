import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_school/Generate/generated/locale_keys.g.dart';
import 'package:flutter_school/Generate/translation.dart';
import 'package:flutter_school/Presentation/Bloc/Authentication/Authentication_bloc.dart';
import 'package:flutter_school/Presentation/Bloc/Authentication/Authentication_event.dart';
import 'package:flutter_school/Presentation/Screen/BottomBar_Screen.dart';


class RegistrationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Register.tr(), style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
         actions: [
          Lang()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 100),
              _buildTextField(nameController,LocaleKeys.Name.tr(), Icons.person),
              SizedBox(height: 10),
              _buildTextField(emailController,LocaleKeys.Mail.tr(), Icons.email),
              SizedBox(height: 10),
              _buildTextField(passwordController,LocaleKeys.Password.tr(), Icons.lock, isPassword: true),
              SizedBox(height: 20),
              _buildElevatedButton(context, LocaleKeys.Regis.tr(), Colors.indigo, Colors.white, () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  SignUpEvent(
                    emailController.text,
                    passwordController.text,
                    nameController.text,
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              }),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[100],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildElevatedButton(BuildContext context, String text, Color color, Color secondaryColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: secondaryColor, backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(vertical: 15),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}