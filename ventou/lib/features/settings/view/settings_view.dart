import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ventou/common/helpers/ui_helper.dart';
import 'package:ventou/common/widgets/custom_scaffold.dart';
import 'package:ventou/core/constants/color_constants.dart';
import 'package:ventou/core/constants/image_constants.dart';
import 'package:ventou/core/constants/supported_locales.dart';
import 'package:ventou/features/bloc/my_user_bloc/my_user_bloc.dart';
import 'package:ventou/features/bloc/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:ventou/features/settings/widget/list_section_widet.dart';
import 'package:ventou/features/settings/widget/list_tile_widget.dart';
import 'package:ventou/features/theme/bloc/theme_bloc.dart';
import 'package:ventou/features/theme/bloc/theme_event.dart';
import 'package:ventou/features/theme/bloc/theme_state.dart';
import 'package:ventou/generated/locale_keys.g.dart';
part "settings_view_mixin.dart";

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SettingsViewMixin {
  @override
  Widget build(BuildContext context) {
    final MyUserBloc myUserBloc = BlocProvider.of<MyUserBloc>(context);
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, loginState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return CustomScaffold(
              onRefresh: () async {
                await Future<void>.delayed(
                  const Duration(milliseconds: 1000),
                );
              },
              title: LocaleKeys.settings,
              children: [
                Column(
                  children: [
                    ListSectionWidget(
                      hasLeading: false,
                      dividerMargin: 0,
                      children: [
                        CupertinoListTile(
                          onTap: () {},
                          backgroundColorActivated: themeState.isDark
                              ? ColorConstants.darkBackgroundColorActivated
                              : ColorConstants.lightBackgroundColorActivated,
                          title: Text(
                            myUserBloc.state.user!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: themeState.isDark
                                  ? ColorConstants.darkInactive
                                  : ColorConstants.lightInactive,
                            ),
                          ),
                          subtitle: Text(
                            myUserBloc.state.user!.email,
                            style: TextStyle(
                              color: themeState.isDark
                                  ? ColorConstants.darkInactive
                                  : ColorConstants.lightInactive,
                            ),
                          ),
                          leadingSize: UIHelper.deviceWidth * 0.12,
                          leading: myUserBloc.state.user!.picture == ""
                              ? GestureDetector(
                                  onTap: () async {
                                    final ImagePicker picker = ImagePicker();
                                    final XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery,
                                        maxHeight: 500,
                                        maxWidth: 500,
                                        imageQuality: 40);
                                    if (image != null) {
                                      CroppedFile? croppedFile =
                                          await ImageCropper().cropImage(
                                        sourcePath: image.path,
                                        aspectRatio: const CropAspectRatio(
                                          ratioX: 1,
                                          ratioY: 1,
                                        ),
                                        uiSettings: [
                                          AndroidUiSettings(
                                            toolbarTitle: 'Cropper',
                                            toolbarColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            // toolbarWidgetColor: Colors.white,
                                            initAspectRatio:
                                                CropAspectRatioPreset.original,
                                            lockAspectRatio: false,
                                          ),
                                          IOSUiSettings(
                                            title: 'Cropper',
                                          ),
                                        ],
                                      );
                                      if (croppedFile != null) {
                                        setState(() {
                                          context
                                              .read<UpdateUserInfoBloc>()
                                              .add(
                                                UploadPicture(
                                                  croppedFile.path,
                                                  context
                                                      .read<MyUserBloc>()
                                                      .state
                                                      .user!
                                                      .id,
                                                ),
                                              );
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: themeState.isDark
                                          ? ColorConstants.darkInactive
                                          : ColorConstants.lightInactive,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      CupertinoIcons.person,
                                      color: CupertinoColors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(500)),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: UIHelper.deviceWidth * 0.12,
                                    imageUrl: myUserBloc.state.user!.picture!,
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            const Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                          ImageConstants.defaultProfilePhoto);
                                    },
                                  ),
                                ),
                          trailing: Icon(
                            CupertinoIcons.forward,
                            color: themeState.isDark
                                ? ColorConstants.darkSecondaryIcon
                                : ColorConstants.lightSecondaryIcon,
                          ),
                        ),
                        ListTileWidget(
                          leadingIcon: CupertinoIcons.bell_fill,
                          leadingColor: CupertinoColors.systemCyan,
                          title: "Notification",
                          onTap: () {},
                          titleTextStyle: TextStyle(
                            color: themeState.isDark
                                ? ColorConstants.darkInactive
                                : ColorConstants.lightInactive,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                ListSectionWidget(
                  children: [
                    ListTileWidget(
                      title: LocaleKeys.theme.tr(),
                      leadingIcon: CupertinoIcons.sun_min_fill,
                      leadingColor: CupertinoColors.systemBlue,
                      onTap: () => _showSelectThemeSheet(context),
                      titleTextStyle: TextStyle(
                        color: themeState.isDark
                            ? ColorConstants.darkInactive
                            : ColorConstants.lightInactive,
                      ),
                    ),
                    ListTileWidget(
                      title: LocaleKeys.language.tr(),
                      leadingIcon: CupertinoIcons.globe,
                      leadingColor: CupertinoColors.systemGreen,
                      onTap: () => _showSelectLanguageSheet(context),
                      titleTextStyle: TextStyle(
                        color: themeState.isDark
                            ? ColorConstants.darkInactive
                            : ColorConstants.lightInactive,
                      ),
                    ),
                  ],
                ),
                ListSectionWidget(
                  children: [
                    ListTileWidget(
                      title: LocaleKeys.logout.tr(),
                      leadingIcon: CupertinoIcons.square_arrow_left_fill,
                      leadingColor: CupertinoColors.systemRed,
                      onTap: () => _showLogOutDialog(context, myUserBloc),
                      titleTextStyle: TextStyle(
                        color: themeState.isDark
                            ? ColorConstants.darkInactive
                            : ColorConstants.lightInactive,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
