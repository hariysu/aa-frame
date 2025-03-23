class UserProfile {
  final String id;
  final String name;
  final int birthYear;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.name,
    required this.birthYear,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  UserProfile copyWith({
    String? name,
    int? birthYear,
    String? photoUrl,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      birthYear: birthYear ?? this.birthYear,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  // Convert UserProfile object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthYear': birthYear,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
    };
  }

  // Create UserProfile object from Firestore document
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      birthYear: map['birthYear'] ?? 0,
      photoUrl: map['photoUrl'],
      createdAt: (map['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as dynamic)?.toDate() ?? DateTime.now(),
    );
  }

  // Create a new UserProfile with default values
  factory UserProfile.create(String userId, String name, int birthYear) {
    final now = DateTime.now();
    return UserProfile(
      id: userId,
      name: name,
      birthYear: birthYear,
      photoUrl: null,
      createdAt: now,
      updatedAt: now,
    );
  }
}
