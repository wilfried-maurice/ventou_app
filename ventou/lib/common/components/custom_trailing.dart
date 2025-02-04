import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventou/core/constants/color_constants.dart';
import 'package:ventou/features/theme/bloc/theme_bloc.dart';
import 'package:ventou/features/theme/bloc/theme_state.dart';

class CustomTrailing extends StatelessWidget {
  final String text;
  final bool isLoading;
  final bool showLoadingIndicator;
  final void Function()? onPressed;
  const CustomTrailing({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.showLoadingIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (isLoading && showLoadingIndicator)
                ? const CupertinoActivityIndicator()
                : CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: isLoading ? null : onPressed,
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isLoading
                            ? themeState.isDark
                                ? ColorConstants.darkInactive
                                : ColorConstants.lightInactive
                            : themeState.isDark
                                ? ColorConstants.darkPrimaryIcon
                                : ColorConstants.lightPrimaryIcon,
                      ),
                    ).tr(),
                  ),
          ],
        );
      },
    );
  }
}
