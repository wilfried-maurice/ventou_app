import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:ventou/generated/locale_keys.g.dart';

class UnauthenticatedUserWidget extends StatelessWidget {
  const UnauthenticatedUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: const Text(LocaleKeys.unauthenticated_user).tr(),
    ));
  }
}
