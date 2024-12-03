class UserModel {
  String? about;
  DateTime? createdAt;
  String? email;
  String? id;
  String? image;
  bool? isOnline;
  DateTime? lastActive;
  String? name;
  String? pushTokens;

  UserModel({
    this.about,
    this.createdAt,
    this.email,
    this.id,
    this.image,
    this.isOnline,
    this.lastActive,
    this.name,
    this.pushTokens,
  });

  // Factory method to create a UserModel instance from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic> json) {
    return UserModel(
      about: json['about'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      email: json['email'] as String?,
      id: json['id'] as String?,
      image: json['image'] as String?,
      isOnline: json['is_online'] == "true",
      lastActive: json['last_active'] != null
          ? DateTime.tryParse(json['last_active'] as String)
          : null,
      name: json['name'] as String?,
      pushTokens: json['push_tokens'] as String?,
    );
  }

  // Method to convert a UserModel instance to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'about': about,
      'created_at': createdAt?.toIso8601String(),
      'email': email,
      'id': id,
      'image': image,
      'is_online': isOnline != null ? isOnline.toString() : null,
      'last_active': lastActive?.toIso8601String(),
      'name': name,
      'push_tokens': pushTokens,
    };
  }
}
