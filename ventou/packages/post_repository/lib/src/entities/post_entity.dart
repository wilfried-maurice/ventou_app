import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class PostEntity {
  String postId;
  String post;
  DateTime createAt;
  MyUser myUser;
  String image; // Nouvelle propriété
  double price; // Nouvelle propriété
  String? description; // Nouvelle propriété
  String phone; // Nouvelle propriété

  PostEntity({
    required this.postId,
    required this.post,
    required this.createAt,
    required this.myUser,
    required this.image, // Initialisation de la nouvelle propriété
    required this.price, // Initialisation de la nouvelle propriété
    this.description, // Initialisation de la nouvelle propriété
    required this.phone, // Initialisation de la nouvelle propriété
  });

  /// Convert PostEntity to a Firestore document
  Map<String, Object?> toDocument() {
    return {
      'postId': postId,
      'post': post,
      'createAt': createAt,
      'myUser': myUser.toEntity().toDocument(),
      'image': image, // Ajout de la nouvelle propriété
      'price': price, // Ajout de la nouvelle propriété
      'description': description, // Ajout de la nouvelle propriété
      'phone': phone, // Ajout de la nouvelle propriété
    };
  }

  /// Create PostEntity from a Firestore document
  static PostEntity fromDocument(Map<String, dynamic> doc) {
    return PostEntity(
      postId: doc['postId'] as String,
      post: doc['post'] as String,
      createAt: (doc['createAt'] as Timestamp).toDate(),
      myUser: MyUser.fromEntity(MyUserEntity.fromDocument(doc['myUser'])),
      image: doc['image'] as String, // Récupération de la nouvelle propriété
      price: doc['price'] as double, // Récupération de la nouvelle propriété
      description:
          doc['description'] as String, // Récupération de la nouvelle propriété
      phone: doc['phone'] as String, // Récupération de la nouvelle propriété
    );
  }

  @override
  List<Object?> get props => [
        postId,
        post,
        createAt,
        myUser,
        image, // Ajout de la nouvelle propriété
        price, // Ajout de la nouvelle propriété
        description, // Ajout de la nouvelle propriété
        phone, // Ajout de la nouvelle propriété
      ];

  @override
  String toString() {
    return '''PostEntity: {
      postId: $postId
      post: $post
      createAt: $createAt
      myUser: $myUser
      image: $image
      price: $price
      description: $description
      phone: $phone
    }''';
  }
}
