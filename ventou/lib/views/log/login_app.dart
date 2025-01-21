import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ventou/constants/constant.dart';
import 'package:ventou/views/layout_view.dart';
import 'package:ventou/views/log/button_login.dart';
import 'package:ventou/views/sign/sign_app.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhite1,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.kPrimary3,
                  AppColor.kPrimary2,
                  AppColor.kPrimary5,
                ],
                stops: const [0, 0.5, 0.5],
                begin: const Alignment(0, -1),
                end: const Alignment(1, 1),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 105),
              child: SizedBox(
                child: Image.asset(
                  'assets/vent-w-.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(top: 170),
            child: Container(
              padding: const EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                color: AppColor.kWhite1,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Connectez-vous',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColor.kPrimary5,
                            ),
                          ),
                          Text(
                            'Bienvenue sur Ventou',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.kGrayscale39,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          children: [
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
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // RememberMeCard(
                                //   onChanged: (value) {
                                //     setState(() {
                                //       isRemember = value;
                                //     });
                                //   },
                                // ),
                                // const Spacer(),
                                CustomTextButton(
                                  onPressed: () {},
                                  text: 'Mot de passe oublie?',
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            ButtonLogin(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {}
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (_) => const LayoutView(),
                                  ),
                                );
                              },
                              text: 'Connexion',
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                text: 'Vous n’avez pas de compte ? ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.kGrayscale40,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Inscrivez-vous',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const SignUpApp()),
                                        );
                                      },
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
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
                                  icon: ImagesPath.ktwitter,
                                ),
                                CustomSocialButton(
                                  onTap: () {},
                                  icon: ImagesPath.kface,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // const AgreeTermsTextCard(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
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
          text: 'By signing up you agree to our ',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.kGrayscale41),
          children: [
            TextSpan(
              text: 'Terms',
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.kGrayscale41),
            ),
            TextSpan(
              text: ' and ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.kGrayscale40),
            ),
            TextSpan(
              text: 'Conditions of Use',
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.kGrayscaleDark100),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CustomSocialButton extends StatefulWidget {
  final String icon;
  final VoidCallback onTap;
  const CustomSocialButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  State<CustomSocialButton> createState() => _CustomSocialButtonState();
}

class _CustomSocialButtonState extends State<CustomSocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColor.kGrayscale41,
            image: DecorationImage(image: AssetImage(widget.icon)),
          ),
        ),
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
          fontSize: fontSize ?? 12,
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
            width: 20,
            height: 20,
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
          'Se souvenir de moi',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF78828A),
          ),
        ),
      ],
    );
  }
}
