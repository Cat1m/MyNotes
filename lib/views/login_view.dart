import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/widgets/custom_textfield.dart';
import 'package:mynotes/widgets/show_error_dialog.dart';
import 'package:mynotes/widgets/toast_helper.dart';
import 'dart:developer' as devtools show log;

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
                            .signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        final user = FirebaseAuth.instance.currentUser;
                        if (user?.emailVerified ?? false) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            notesRoute,
                            (route) => false,
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            verifyEmailRoute,
                            (route) => false,
                          );
                        }
                        ToastHelper.showToast('Đăng nhập thành công!');
                        // ignore: use_build_context_synchronously

                        devtools.log(userCredential.toString());
                      }
                      //print(e.runtimeType); xem type lỗi
                      on FirebaseAuthException catch (e) {
                        String errorMessage;
                        switch (e.code) {
                          case 'channel-error':
                            errorMessage = 'Vui lòng điền đủ thông tin';
                            break;
                          case 'invalid-email':
                            errorMessage = 'Email không hợp lệ';
                            break;
                          case 'invalid-credential':
                            // ignore: use_build_context_synchronously
                            await showErrorDialog(
                              context,
                              "Thông tin đăng nhập không chính xác\nVui lòng kiểm tra lại",
                            );
                            errorMessage =
                                'Thông tin đăng nhập không chính xác\nVui lòng kiểm tra lại';
                            break;
                          default:
                            errorMessage = "Lỗi ${e.code}";
                        }
                        ToastHelper.showToast(errorMessage);
                      } catch (e) {
                        devtools.log(e.toString());
                        // ignore: use_build_context_synchronously
                        await showErrorDialog(
                          context,
                          e.toString(),
                        );
                      }
                    },
                    child: const Text('ĐĂNG NHẬP'),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute, (route) => false);
                    },
                    child: const Text('ĐĂNG KÍ'),
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
