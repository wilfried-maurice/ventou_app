import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:ventou/app.dart';
import 'package:ventou/core/services/shared_preferences_service.dart';
import 'package:ventou/core/services/theme_service.dart';
import 'package:ventou/core/utils/localization/localization_manager.dart';
import 'package:ventou/features/theme/bloc/theme_bloc.dart';
import 'package:ventou/simple_bloc_observer.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() async {
//   await dotenv.load();
//   await SharedPreferencesService.instance.init();
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   ThemeService.getTheme();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   Bloc.observer = SimpleBlocObserver();
//   runApp(
//     CustomMultiBlocProvider(
//       child: LocalizationManager(
//         child: const MyApp(),
//       ),
//     ),
//   );
// }
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     ThemeService.initialize(context);
//     super.initState();
//   }
//   @override
//   Future<void> didChangeDependencies() async {
//     ThemeService.autoChangeTheme(context);
//     super.didChangeDependencies();
//
//   @override
//   Widget build(BuildContext context) {
//     UIHelper.initialize(context);
//     return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
//       return CupertinoApp.router(
//         localizationsDelegates: context.localizationDelegates,
//         supportedLocales: context.supportedLocales,
//         locale: context.locale,
//         title: 'Ventou App',
//         theme: ThemeService.buildTheme(themeState),
//         debugShowCheckedModeBanner: false,
//         routerConfig: RouterManager.router,
//       );
//     });
//   }
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ventou ',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Color(0X0081889d)),
//           textTheme: GoogleFonts.montserratTextTheme(),
//           useMaterial3: true),
//       darkTheme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color(0X006b6ab3)),
//         textTheme: GoogleFonts.montserratTextTheme(),
//       ),
//       home: const OnboardingScreen(),
//     );
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance.init();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  ThemeService.getTheme();

  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(
    LocalizationManager(
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: MainApp(
          FirebaseUserRepository(),
        ),
      ),
    ),
  );
}
