import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/widgets/custom_textfield.dart';
import 'package:mynotes/widgets/toast_helper.dart';

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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // case ConnectionState.none:
            // case ConnectionState.waiting:
            // case ConnectionState.active:
            case ConnectionState.done:
              return Column(
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
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        // ignore: avoid_print
                        print(userCredential);
                        ToastHelper.showToast('Đăng kí thành công!');
                      } on FirebaseAuthException catch (e) {
                        String errorMessage;
                        switch (e.code) {
                          case 'weak-password':
                            errorMessage = "Mật khẩu yếu";
                            break;
                          case 'email-already-in-use':
                            errorMessage = "Email đã được sử dụng";
                            break;
                          case "invalid-email":
                            errorMessage = "Email không hợp lệ";
                            break;
                          default:
                            errorMessage = "Kiểm tra lại thông tin";
                        }
                        ToastHelper.showToast(errorMessage);
                      }
                    },
                    child: const Text('ĐĂNG KÍ'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/login/', (route) => false);
                    },
                    child: const Text('Bạn đã có tài khoảng! đi đến đăng nhập'),
                  )
                ],
              );
            //dùng defaulf để xử lí các case còn lại
            default:
              return const Center(child: Text("Đang tải..."));
          }
        },
      ),
    );
  }
}
