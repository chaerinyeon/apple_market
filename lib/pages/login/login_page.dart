// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/product_list/product_list_page.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../register/register_page.dart';
import 'widgets/input_field.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/form_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController useridController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? useridError;
  String? passwordError;

  @override
  void dispose() {
    useridController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void resetErrorText() {
    setState(() {
      useridError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    bool isValid = true;
    if (useridController.text.isEmpty) {
      setState(() {
        useridError = '아이디를 입력해주세요.';
      });
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = '비밀번호를 입력해주세요.';
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() async {
    if (validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      bool success = await authProvider.login(
        useridController.text,
        passwordController.text,
      );

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProductListPage()),
        );
      } else {
        final error = authProvider.errorMessage ?? '로그인에 실패했습니다.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .12),
            Center(
              child: const Text(
                '환영합니다',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Center(
              child: Text(
                '로그인을 해주세요!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(.6),
                ),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            InputField(
              labelText: '아이디',
              keyboardType: TextInputType.emailAddress,
              controller: useridController,
              errorText: useridError,
              icon: Icons.person,
              onChanged: (value) {
                if (useridError != null) {
                  setState(() {
                    useridError = null;
                  });
                }
              },
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              labelText: '비밀번호',
              obscureText: true,
              controller: passwordController,
              errorText: passwordError,
              icon: Icons.lock,
              onChanged: (value) {
                if (passwordError != null) {
                  setState(() {
                    passwordError = null;
                  });
                }
              },
              onSubmitted: (val) => submit(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '비밀번호를 잊으셨나요?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            authProvider.isLoading
                ? const LoadingIndicator()
                : FormButton(
                    text: '로그인',
                    onPressed: submit,
                  ),
            SizedBox(
              height: screenHeight * .15,
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RegisterPage(),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  text: "새 사용자이신가요? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: '회원가입',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
