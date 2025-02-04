part of "settings_view.dart";

mixin SettingsViewMixin on State<SettingsView> {
  void _showSelectThemeSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(LocaleKeys.theme).tr(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            if (context.canPop()) context.pop();
          },
          child: const Text(LocaleKeys.cancel).tr(),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Brightness brightness = SchedulerBinding
                  .instance.platformDispatcher.platformBrightness;
              BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(
                  useDeviceTheme: true, isDark: brightness == Brightness.dark));
              if (context.canPop()) context.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(LocaleKeys.device_theme).tr(),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return state.useDeviceTheme
                        ? const Icon(CupertinoIcons.checkmark)
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              BlocProvider.of<ThemeBloc>(context)
                  .add(const ChangeTheme(useDeviceTheme: false, isDark: false));
              if (context.canPop()) context.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(LocaleKeys.light_theme).tr(),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return (!state.isDark && !state.useDeviceTheme)
                        ? const Icon(CupertinoIcons.checkmark)
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              BlocProvider.of<ThemeBloc>(context)
                  .add(const ChangeTheme(useDeviceTheme: false, isDark: true));
              if (context.canPop()) context.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(LocaleKeys.dark_theme).tr(),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return (state.isDark && !state.useDeviceTheme)
                        ? const Icon(CupertinoIcons.checkmark)
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectLanguageSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(LocaleKeys.language).tr(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            if (context.canPop()) context.pop();
          },
          child: const Text(LocaleKeys.cancel).tr(),
        ),
        actions: SuppertedLocales.supportedLanguages
            .map(
              (lang) => CupertinoActionSheetAction(
                onPressed: () async {
                  await context.setLocale(Locale(lang.entries.first.key));
                  WidgetsBinding.instance.reassembleApplication();
                  if (context.mounted) {
                    if (context.canPop()) context.pop();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lang.entries.first.value),
                    context.locale.languageCode == lang.entries.first.key
                        ? const Icon(CupertinoIcons.checkmark)
                        : const SizedBox(),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void _showLogOutDialog(BuildContext context, MyUserBloc myUserBloc) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(LocaleKeys.logout).tr(),
          content: const Text(LocaleKeys.ays_logout).tr(),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(LocaleKeys.no).tr(),
              onPressed: () {
                if (context.canPop()) context.pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text(LocaleKeys.yes).tr(),
              onPressed: () {
                // loginBloc.add(const LogoutButtonPressed());
                // context.go(Routes.login.path);
              },
            ),
          ],
        );
      },
    );
  }
}
