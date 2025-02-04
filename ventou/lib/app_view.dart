import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_repository/post_repository.dart';
import 'package:ventou/common/helpers/ui_helper.dart';
import 'package:ventou/core/constants/constant.dart';
import 'package:ventou/core/services/theme_service.dart';
import 'package:ventou/features/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:ventou/features/bloc/get_post_bloc/get_post_bloc.dart';
import 'package:ventou/features/bloc/my_user_bloc/my_user_bloc.dart';
import 'package:ventou/features/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:ventou/features/bloc/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:ventou/features/authentication/welcome_screen.dart';
import 'package:ventou/features/tabbar/tabbar.dart';
import 'package:ventou/features/theme/bloc/theme_bloc.dart';
import 'package:ventou/features/theme/bloc/theme_state.dart';

import 'package:ventou/routes.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  bool _isInitialized = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    ThemeService.autoChangeTheme(context);
    super.didChangeDependencies();
    if (!_isInitialized) {
      ThemeService.initialize(context);
      ThemeService.autoChangeTheme(context);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    UIHelper.initialize(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: routes,
          title: 'Ventou',
          theme: ThemeService.buildTheme(themeState),
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
                            myUserId: context
                                .read<AuthenticationBloc>()
                                .state
                                .user!
                                .uid),
                      ),
                  ),
                  BlocProvider(
                    create: (context) => GetPostBloc(
                      postRepository: FirebasePostRepository(),
                    )..add(GetPosts()),
                  ),
                  BlocProvider(
                    create: (context) => ThemeBloc(),
                  ),
                ],
                child: const FRTabbarScreen(),
              );
            } else {
              return const WelcomeScreen();
            }
          }),
        );
      },
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);
  return baseTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.kPrimary5),
    textTheme: GoogleFonts.montserratTextTheme(baseTheme.textTheme),
  );
}
