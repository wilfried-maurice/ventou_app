import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ventou/core/constants/constants.dart';
import 'package:ventou/features/bloc/my_user_bloc/my_user_bloc.dart';
import 'package:ventou/features/bloc/update_user_info_bloc/update_user_info_bloc.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, state) {
        if (state.status == MyUserStatus.success) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                state.user!.picture == ""
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
                                  toolbarColor:
                                      Theme.of(context).colorScheme.primary,
                                  toolbarWidgetColor: Colors.white,
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
                                context.read<UpdateUserInfoBloc>().add(
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
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle),
                          child: Icon(
                            CupertinoIcons.person,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                state.user!.picture!,
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Salut 👋',
                          style: TextStyle(
                            color: Color(0xFF2E384D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          state.user!.name,
                          style: TextStyle(
                            color: Color(0xFF2E384D),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 8,
                  icon: Image.asset(
                    '$kIconPath/notification.png',
                    width: 25,
                    height: 25,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
