import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final Uri _url = Uri.parse('https://mail.google.com/mail/u/0/#inbox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác thực Email'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(10),
          const Text(
            "Chúng tôi đã gửi cho bạn một Email xác thực\nVui lòng kiểm tra mail và xác nhận tài khoảng",
            textAlign: TextAlign.center,
          ),
          const Gap(10),
          const Text(
            "nếu bạn vẫn chưa nhận được Email xác thực\nVui lòng ấn vào nút bên dưới!",
            textAlign: TextAlign.center,
          ),
          const Gap(10),
          FilledButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('Gửi lại mail xác thực'),
          ),
          const Gap(10),
          TextButton(
            onPressed: _launchUrl,
            child: const Text('Kiểm tra Mail'),
          ),
          const Gap(10),
          FilledButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("Đi đến đăng nhập"),
          ),
          const Gap(10),
          FilledButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text("Đăng ký với Email Khác"))
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
