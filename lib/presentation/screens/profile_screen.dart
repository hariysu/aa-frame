import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils.dart';
import '../../data/models/user_profile.dart';
import '../../data/services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthYearController = TextEditingController();
  final _profileService = ProfileService();

  UserProfile? _userProfile;
  bool _isLoading = true;
  bool _isSaving = false;
  File? _imageFile;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthYearController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    setState(() => _isLoading = true);
    try {
      final profile = await _profileService.getCurrentUserProfile();
      setState(() {
        _userProfile = profile;
        _photoUrl = profile?.photoUrl;

        if (profile != null) {
          _nameController.text = profile.name;
          _birthYearController.text = profile.birthYear.toString();
        }
      });
    } catch (e) {
      Utils.showSnackBar(context, 'Error loading profile: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      // Parse birth year
      final birthYear =
          int.tryParse(_birthYearController.text) ?? DateTime.now().year;

      // Save profile data
      await _profileService.saveUserProfile(
        name: _nameController.text.trim(),
        birthYear: birthYear,
      );

      // Upload profile picture if selected
      if (_imageFile != null) {
        final downloadUrl =
            await _profileService.uploadProfilePicture(_imageFile!);
        setState(() => _photoUrl = downloadUrl);
      }

      if (mounted) {
        Utils.showSnackBar(context, 'Profile updated successfully!');
      }

      // Reload profile
      await _loadUserProfile();
    } catch (e) {
      if (mounted) {
        Utils.showSnackBar(context, 'Error saving profile: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() => _imageFile = File(pickedFile.path));
      }
    } catch (e) {
      Utils.showSnackBar(context, 'Error picking image: ${e.toString()}');
    }
  }

  Future<void> _takePhoto() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() => _imageFile = File(pickedFile.path));
      }
    } catch (e) {
      Utils.showSnackBar(context, 'Error taking photo: ${e.toString()}');
    }
  }

  Future<void> _removePhoto() async {
    setState(() => _isSaving = true);
    try {
      await _profileService.deleteProfilePicture();
      setState(() {
        _photoUrl = null;
        _imageFile = null;
      });
      if (mounted) {
        Utils.showSnackBar(context, 'Profile picture removed');
      }
    } catch (e) {
      if (mounted) {
        Utils.showSnackBar(context, 'Error removing photo: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _takePhoto();
                },
              ),
              if (_photoUrl != null || _imageFile != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    'Remove Photo',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _removePhoto();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfilePhoto() {
    final double photoSize = 120;

    Widget photoWidget;

    if (_imageFile != null) {
      // Show selected image file
      photoWidget = ClipRRect(
        borderRadius: BorderRadius.circular(photoSize / 2),
        child: Image.file(
          _imageFile!,
          width: photoSize,
          height: photoSize,
          fit: BoxFit.cover,
        ),
      );
    } else if (_photoUrl != null) {
      // Show existing photo from URL
      photoWidget = ClipRRect(
        borderRadius: BorderRadius.circular(photoSize / 2),
        child: Image.network(
          _photoUrl!,
          width: photoSize,
          height: photoSize,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: photoSize,
              height: photoSize,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: photoSize,
              height: photoSize,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.grey,
              ),
            );
          },
        ),
      );
    } else {
      // Show placeholder
      photoWidget = Container(
        width: photoSize,
        height: photoSize,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.person,
          size: 60,
          color: Colors.grey,
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        photoWidget,
        GestureDetector(
          onTap: _isSaving ? null : _showImageSourceActionSheet,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Icon(
              _photoUrl != null || _imageFile != null
                  ? Icons.edit
                  : Icons.add_a_photo,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    _buildProfilePhoto(),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _birthYearController,
                      decoration: const InputDecoration(
                        labelText: 'Birth Year',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                        hintText: 'e.g., 1990',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your birth year';
                        }

                        final year = int.tryParse(value);
                        if (year == null) {
                          return 'Please enter a valid year';
                        }

                        final currentYear = DateTime.now().year;
                        if (year < 1900 || year > currentYear) {
                          return 'Please enter a year between 1900 and $currentYear';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isSaving
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Save Profile',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
