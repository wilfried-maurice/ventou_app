import 'package:user_repository/user_repository.dart';
import '../entities/entities.dart';

class Post {
  String postId;
  String post;
  DateTime createAt;
  MyUser myUser;
  String image; // Nouvelle propriété pour l'image
  double price; // Nouvelle propriété pour le prix
  String? description; // Nouvelle propriété pour la description
  String phone; // Nouvelle propriété pour le numéro de téléphone

  Post({
    required this.postId,
    required this.post,
    required this.createAt,
    required this.myUser,
    required this.image, // Initialisation de la nouvelle propriété
    required this.price, // Initialisation de la nouvelle propriété
    this.description, // Initialisation de la nouvelle propriété
    required this.phone, // Initialisation de la nouvelle propriété
  });

  /// Empty post which represents an empty post.
  static final empty = Post(
    postId: '',
    post: '',
    createAt: DateTime.now(),
    myUser: MyUser.empty,
    image: '', // Valeur par défaut pour l'image
    price: 0.0, // Valeur par défaut pour le prix
    description: '', // Valeur par défaut pour la description
    phone: '', // Valeur par défaut pour le téléphone
  );

  /// Modify Post parameters
  Post copyWith({
    String? postId,
    String? post,
    DateTime? createAt,
    MyUser? myUser,
    String? image, // Nouvelle propriété dans copyWith
    double? price, // Nouvelle propriété dans copyWith
    String? description, // Nouvelle propriété dans copyWith
    String? phone, // Nouvelle propriété dans copyWith
  }) {
    return Post(
      postId: postId ?? this.postId,
      post: post ?? this.post,
      createAt: createAt ?? this.createAt,
      myUser: myUser ?? this.myUser,
      image: image ?? this.image, // Copie de la nouvelle propriété
      price: price ?? this.price, // Copie de la nouvelle propriété
      description:
          description ?? this.description, // Copie de la nouvelle propriété
      phone: phone ?? this.phone, // Copie de la nouvelle propriété
    );
  }

  /// Convenience getter to determine whether the current post is empty.
  bool get isEmpty => this == Post.empty;

  /// Convenience getter to determine whether the current post is not empty.
  bool get isNotEmpty => this != Post.empty;

  /// Convert Post to PostEntity
  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      post: post,
      createAt: createAt,
      myUser: myUser,
      image: image, // Ajout de la nouvelle propriété dans l'entité
      price: price, // Ajout de la nouvelle propriété dans l'entité
      description: description!, // Ajout de la nouvelle propriété dans l'entité
      phone: phone, // Ajout de la nouvelle propriété dans l'entité
    );
  }

  /// Create Post from PostEntity
  static Post fromEntity(PostEntity entity) {
    return Post(
      postId: entity.postId,
      post: entity.post,
      createAt: entity.createAt,
      myUser: entity.myUser,
      image: entity.image, // Ajout de la nouvelle propriété
      price: entity.price, // Ajout de la nouvelle propriété
      description: entity.description, // Ajout de la nouvelle propriété
      phone: entity.phone, // Ajout de la nouvelle propriété
    );
  }

  @override
  String toString() {
    return '''Post: {
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
