import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart'; // Generated file

@HiveType(typeId: 0) // Unique typeId for each model
class UserModel extends User {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String email;
  
  @HiveField(2)
  final String name;
  
  @HiveField(3)
  final String? phoneNumber;
  
  @HiveField(4)
  final String? photoUrl;
  
  @HiveField(5)
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.photoUrl,
    required this.createdAt,
  }) : super(
          id: id,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          photoUrl: photoUrl,
          createdAt: createdAt,
        );

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // From Entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoUrl,
      createdAt: user.createdAt,
    );
  }

  // To Entity
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
      createdAt: createdAt,
    );
  }
}