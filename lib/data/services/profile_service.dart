import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_profile.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Get user profile document reference
  DocumentReference<Map<String, dynamic>> _userDocRef(String userId) =>
      _usersCollection.doc(userId);

  // Get storage reference for profile pictures
  Reference _profilePicRef(String userId) =>
      _storage.ref().child('profile_pictures').child('$userId.jpg');

  // Get user profile from Firestore
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final doc = await _userDocRef(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserProfile.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Get current user's profile
  Future<UserProfile?> getCurrentUserProfile() async {
    if (currentUserId == null) return null;
    return getUserProfile(currentUserId!);
  }

  // Save user profile to Firestore
  Future<void> saveUserProfile({
    required String name,
    required int birthYear,
  }) async {
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final existingProfile = await getCurrentUserProfile();

      final UserProfile profile;
      if (existingProfile != null) {
        // Update existing profile
        profile = existingProfile.copyWith(
          name: name,
          birthYear: birthYear,
        );
      } else {
        // Create new profile
        profile = UserProfile.create(
          currentUserId!,
          name,
          birthYear,
        );
      }

      await _userDocRef(currentUserId!).set(profile.toMap());
      return;
    } catch (e) {
      rethrow;
    }
  }

  // Upload profile picture to Firebase Storage
  Future<String> uploadProfilePicture(File imageFile) async {
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      // Create storage reference
      final ref = _profilePicRef(currentUserId!);

      // Upload image
      await ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Get download URL
      final downloadUrl = await ref.getDownloadURL();

      // Update profile with new photo URL
      final userProfile = await getCurrentUserProfile();
      if (userProfile != null) {
        final updatedProfile = userProfile.copyWith(photoUrl: downloadUrl);
        await _userDocRef(currentUserId!).update({
          'photoUrl': downloadUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  // Delete profile picture
  Future<void> deleteProfilePicture() async {
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final userProfile = await getCurrentUserProfile();
      if (userProfile?.photoUrl != null) {
        // Delete from storage
        await _profilePicRef(currentUserId!).delete();

        // Update profile
        await _userDocRef(currentUserId!).update({
          'photoUrl': null,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      rethrow;
    }
  }
}
