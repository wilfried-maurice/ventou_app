import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventou/core/services/theme_service.dart';
import 'package:ventou/features/theme/bloc/theme_event.dart';
import 'package:ventou/features/theme/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ChangeTheme>((event, emit) async {
      ThemeService.setTheme(
          useDeviceTheme: event.useDeviceTheme, isDark: event.isDark);
      emit(ThemeState(
          useDeviceTheme: event.useDeviceTheme, isDark: event.isDark));
    });
  }
}
