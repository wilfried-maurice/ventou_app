import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventou/core/constants/color_constants.dart';
import 'package:ventou/features/theme/bloc/theme_bloc.dart';
import 'package:ventou/features/theme/bloc/theme_state.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final Color? leadingColor;
  final FutureOr<void> Function()? onTap;
  final TextStyle? titleTextStyle;
  const ListTileWidget({
    super.key,
    required this.title,
    this.leadingIcon,
    this.leadingColor = CupertinoColors.systemBlue,
    this.onTap,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return CupertinoListTile(
          backgroundColor: CupertinoDynamicColor.withBrightness(
            color: ColorConstants.lightItem,
            darkColor: ColorConstants.darkItem,
          ),
          backgroundColorActivated: state.isDark
              ? ColorConstants.darkBackgroundColorActivated
              : ColorConstants.lightBackgroundColorActivated,
          onTap: onTap,
          title: Text(
            title,
            style: titleTextStyle,
          ),
          leading: leadingIcon == null
              ? null
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: leadingColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    leadingIcon,
                    color: CupertinoColors.white,
                    size: 20,
                  ),
                ),
          trailing: onTap == null
              ? null
              : BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return Icon(
                      CupertinoIcons.forward,
                      color: state.isDark
                          ? ColorConstants.darkSecondaryIcon
                          : ColorConstants.lightSecondaryIcon,
                    );
                  },
                ),
        );
      },
    );
  }
}
