// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/widgets/custom_textfield.dart';
import 'package:mynotes/widgets/show_error_dialog.dart';
import 'package:mynotes/widgets/toast_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('ĐĂNG NHẬP'),
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
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  'User not found',
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  'sai nhật khẩu',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Lỗi đăng nhập',
                );
              }
            },
            child: const Text('ĐĂNG NHẬP'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('ĐĂNG KÍ'),
          )
        ],
      ),
    );
  }
}
