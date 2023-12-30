// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/widgets/custom_textfield.dart';
import 'package:mynotes/widgets/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController(text: 'chien120697@gmail.com');
    _password = TextEditingController(text: 'Chien1102');
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('ĐĂNG KÍ'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Gap(10),
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            hintText: 'Nhập email',
          ),
          CustomTextField(
            enableSuggestions: false,
            autoCorrect: false,
            obscureText: true,
            controller: _password,
            hintText: 'Nhập mật khẩu',
          ),
          FilledButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase()
                    .createUser(email: email, password: password);
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Weak password',
                );
              } on EmailAlreadyAndUseAuthException {
                await showErrorDialog(
                  context,
                  'Email is already in use',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  'This is an invalid email address',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Failed to register',
                );
              }
            },
            child: const Text('ĐĂNG KÍ'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Bạn đã có tài khoảng! đi đến đăng nhập'),
          )
        ],
      ),
    );
  }
}
