import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ventou/constants/constant.dart';
import 'package:ventou/views/log/login_app.dart';
import 'package:ventou/views/sign/button_sign.dart';

class SignUpApp extends StatefulWidget {
  const SignUpApp({super.key});

  @override
  State<SignUpApp> createState() => _SignUpAppState();
}

class _SignUpAppState extends State<SignUpApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhite1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: AppColor.kPrimary3,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const Text(
                  'COMMENCER PAR CRÉER UN COMPTE',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                // Text(
                //   'Lorem ipsum dolor sit amet, consectetur',
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: AppColor.kPrimary5,
                //   ),
                // ),
                const SizedBox(height: 30),
                // FullName.
                AuthField(
                  title: 'Nom complet',
                  hintText: 'Entrer le nom complet',
                  controller: _nameController,
                  validator: (value) {
                    // if (value == null || value.isEmpty) {
                    //   return 'Nom est requis';
                    // } else if (!RegExp(r'^[a-zA-Z ]+ $').hasMatch(value)) {
                    //   return 'entrer un  name valide';
                    // }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                // Email Field.
                AuthField(
                  title: 'E-mail',
                  hintText: 'Entrer l\'adresse email',
                  controller: _emailController,
                  validator: (value) {
                    // if (value == null || value.isEmpty) {
                    //   return 'Email est requise';
                    // } else if (!value.isEmpty) {
                    //   return '  addresse email invalide';
                    // }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                // Password Field.
                AuthField(
                  title: 'Mot de passe',
                  hintText: 'Entrer le mot de passe',
                  controller: _passwordController,
                  validator: (value) {
                    // if (value == null || value.isEmpty) {
                    //   return 'Mot de passe est requis';
                    // } else if (value.length < 8) {
                    //   return 'mot de passe doit avoir au moins 8 caractères';
                    // }
                    return null;
                  },
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 30),
                Button(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {}
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (_) => const LoginApp()),
                    );
                  },
                  text: 'Créer un compte',
                ),
                const SizedBox(height: 30),
                const TextWithDivider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomSocialButton(
                      onTap: () {},
                      icon: ImagesPath.kgoogle,
                    ),
                    CustomSocialButton(
                      onTap: () {},
                      icon: ImagesPath.kface,
                    ),
                    CustomSocialButton(
                      onTap: () {},
                      icon: ImagesPath.ktwitter,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const AgreeTermsTextCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AgreeTermsTextCard extends StatelessWidget {
  const AgreeTermsTextCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: RichText(
        text: TextSpan(
          text: 'En s’inscrivant, vous acceptez les ',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.kGrayscale40),
          children: [
            TextSpan(
              text: 'Termes',
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColor.kGrayscale40,
              ),
            ),
            TextSpan(
              text: ' et ',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColor.kGrayscale40,
              ),
            ),
            TextSpan(
              text: 'Conditions d\'utilisations',
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TextWithDivider extends StatelessWidget {
  const TextWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColor.kGrayscale41,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          'Ou continuer avec ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColor.kGrayscale40,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Divider(color: AppColor.kGrayscale41),
        ),
      ],
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.red,
          fontSize: fontSize ?? 14,
        ),
      ),
    );
  }
}

class RememberMeCard extends StatefulWidget {
  final Function(bool isChecked) onChanged;
  const RememberMeCard({required this.onChanged, super.key});

  @override
  State<RememberMeCard> createState() => _RememberMeCardState();
}

class _RememberMeCardState extends State<RememberMeCard> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isChecked = !_isChecked;
            });
            widget.onChanged(_isChecked);
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _isChecked
                    ? const Color(0xFFD1A661)
                    : const Color(0xFFE3E9ED),
                width: 2,
              ),
            ),
            child: _isChecked
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Color(0xFFD1A661),
                  )
                : null,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Remember me',
          style: TextStyle(fontSize: 14, color: Color(0xFF78828A)),
        ),
      ],
    );
  }
}

class AuthField extends StatefulWidget {
  final String title;
  final String hintText;
  final Color? titleColor;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int? maxLines;
  const AuthField({
    required this.title,
    required this.hintText,
    required this.controller,
    this.validator,
    this.titleColor,
    this.maxLines,
    this.textInputAction,
    this.keyboardType,
    this.isPassword = false,
    super.key,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: widget.titleColor ?? AppColor.kPrimary5,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          // ignore: avoid_bool_literals_in_conditional_expressions
          obscureText: widget.isPassword ? isObscure : false,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            fillColor: const Color(0xFFFFFFFF),
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.kGrayscale41,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.kGrayscale41,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.kGrayscale41,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.kGrayscale41,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 13, color: AppColor.kGrayscale40),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      size: 16,
                      isObscure ? Icons.visibility : Icons.visibility_off,
                      color: const Color(0xFF171725),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
