// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:ventou/common/components/button_sign.dart';
import 'package:ventou/core/constants/constant.dart';

class PostScreen extends StatefulWidget {
  final MyUser myUser;
  const PostScreen(this.myUser, {super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Post post;
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    post = Post.empty;
    post.myUser = widget.myUser;
    super.initState();
  }

  // 📌 Méthode pour sélectionner une image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // 📌 Méthode pour uploader une image en base64 et l'ajouter au post
  Future<void> _uploadImageToFirestore(String postId) async {
    if (_selectedImage == null) return;

    List<int> imageBytes = await _selectedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // 🔹 Mise à jour du document du post avec l'image
    await FirebaseFirestore.instance.collection('posts').doc(postId).update({
      'image': base64Image,
      'updatedAt': DateTime.now(),
    });

    print("✅ Image enregistrée en base64 dans le document !");
  }

  // 📌 Méthode pour créer un post
  Future<void> _createPost() async {
    if (_postController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      // 🔹 Étape 1 : Créer le post sans image d'abord
      DocumentReference postRef =
          await FirebaseFirestore.instance.collection('posts').add({
        'post': _postController.text,
        'price': double.tryParse(_priceController.text) ?? 0.0,
        'description': _descriptionController.text,
        'phone': _phoneController.text,
        'createdAt': DateTime.now(),
        'image': '', // L’image sera ajoutée après
      });

      if (kDebugMode) {
        print("✅ Post créé avec ID : ${postRef.id}");
      }

      // 🔹 Étape 2 : Uploader l’image et mettre à jour le post
      if (_selectedImage != null) {
        await _uploadImageToFirestore(postRef.id);
      }

      // 🔹 Étape 3 : Fermer l'écran après succès
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Create a Post !'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (_selectedImage == null)
                IconButton(
                    // onPressed: _pickImage,
                    onPressed: () {
                      if (kIsWeb ||
                          Platform.isMacOS ||
                          Platform.isWindows ||
                          Platform.isLinux) {
                        // context.read<UpdateBloc>().add(ChooseImageFromGalleryEvent());
                      } else {
                        final action = CupertinoActionSheet(
                          title: const Text(
                            'Ajouter une photo',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          actions: [
                            CupertinoActionSheetAction(
                              isDefaultAction: false,
                              onPressed: _pickImage,
                              child: const Text(
                                'Choisir depuis la gallerie',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                            CupertinoActionSheetAction(
                              isDestructiveAction: false,
                              onPressed: () async {
                                Navigator.pop(context);
                                // context.read<UpdateBloc>().add(
                                //       CaptureImageByCameraEvent(),
                                //     );
                              },
                              child: const Text(
                                'Prendre une photo',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            )
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text(
                              'Retour',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        );
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => action,
                        );
                      }
                    },
                    icon: Icon(
                      size: 48,
                      color: AppColor.kPrimary3,
                      Icons.camera_alt_outlined,
                    )),
              if (_selectedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(
                    _selectedImage!,
                    height: 150,
                  ),
                ),
              const SizedBox(height: 12),
              TextField(
                controller: _postController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Enter Your Post Here...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter Price",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Enter Description...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Enter Phone Number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Button(onTap: _createPost, text: 'Enregistrer'),
            ],
          ),
        ),
      ),
    );
  }
}

// class PostScreen extends StatefulWidget {
//   final MyUser myUser;
//   const PostScreen(this.myUser, {super.key});
//   @override
//   State<PostScreen> createState() => _PostScreenState();
// }
// class _PostScreenState extends State<PostScreen> {
//   late Post post;
//   final TextEditingController _controller = TextEditingController();
//   File? _image;
//   @override
//   void initState() {
//     post = Post.empty;
//     post.myUser = widget.myUser;
//     super.initState();
//   }
//   Future<void> _pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CreatePostBloc, CreatePostState>(
//       listener: (context, state) {
//         if (state is CreatePostSuccess) {
//           Navigator.pop(context);
//         }
//       },
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           floatingActionButton: FloatingActionButton(
//             onPressed: () async {
//               if (_controller.text.isNotEmpty) {
//                 setState(() {
//                   post.post = _controller.text;
//                 });
//                 if (_image != null) {
//                   final imageUrl = await FirebasePostRepository().uploadImage(_image!);
//                   post.image = imageUrl;
//                 }
//                 context.read<CreatePostBloc>().add(CreatePost(post));
//               }
//             },
//             child: const Icon(CupertinoIcons.add),
//           ),
//           appBar: AppBar(
//             elevation: 0,
//             foregroundColor: Colors.white,
//             title: const Text('Create a Post !'),
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _controller,
//                     maxLines: 10,
//                     maxLength: 500,
//                     decoration: InputDecoration(
//                       hintText: "Enter Your Post Here...",
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                             color: Theme.of(context).colorScheme.primary),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   _image != null
//                       ? Image.file(_image!, height: 150)
//                       : const Text("No image selected"),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.photo_library),
//                         onPressed: () => _pickImage(ImageSource.gallery),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.camera_alt),
//                         onPressed: () => _pickImage(ImageSource.camera),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
