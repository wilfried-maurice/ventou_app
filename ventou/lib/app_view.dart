import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_repository/post_repository.dart';
import 'package:ventou/features/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:ventou/features/bloc/get_post_bloc/get_post_bloc.dart';
import 'package:ventou/features/bloc/my_user_bloc/my_user_bloc.dart';
import 'package:ventou/features/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:ventou/features/bloc/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:ventou/features/authentication/welcome_screen.dart';
import 'package:ventou/features/tabbar/tabbar.dart';
import 'package:ventou/routes.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      title: 'Ventou',
      theme: _buildTheme(Brightness.light),
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: const ColorScheme.light(
      //       surface: Colors.white,
      //       onSurface: Colors.black,
      //       primary: Color.fromRGBO(206, 147, 216, 1),
      //       onPrimary: Colors.black,
      //       secondary: Color.fromRGBO(244, 143, 177, 1),
      //       onSecondary: Colors.white,
      //       tertiary: Color.fromRGBO(255, 204, 128, 1),
      //       error: Colors.red,
      //       outline: Color(0xFF424242)),
      // ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
              ),
              BlocProvider(
                create: (context) => UpdateUserInfoBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
              ),
              BlocProvider(
                create: (context) => MyUserBloc(
                    myUserRepository:
                        context.read<AuthenticationBloc>().userRepository)
                  ..add(
                    GetMyUser(
                        myUserId:
                            context.read<AuthenticationBloc>().state.user!.uid),
                  ),
              ),
              BlocProvider(
                create: (context) => GetPostBloc(
                  postRepository: FirebasePostRepository(),
                )..add(GetPosts()),
              )
            ],
            child: const FRTabbarScreen(),
          );
        } else {
          return const WelcomeScreen();
        }
      }),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);
  return baseTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
    textTheme: GoogleFonts.montserratTextTheme(baseTheme.textTheme),
  );
}
