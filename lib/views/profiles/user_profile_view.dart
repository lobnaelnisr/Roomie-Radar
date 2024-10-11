import 'package:flutter/material.dart';
import 'package:roomie_radar/viewmodels/user_profile_view_model.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final UserProfileViewModel _viewModel = UserProfileViewModel();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    await _viewModel.fetchUserProfile();
    if (_viewModel.user != null) {
      _nameController.text = _viewModel.user!.name;
      _bioController.text = _viewModel.user!.bio ?? '';
      setState(() {}); // Trigger rebuild to update UI with fetched data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _viewModel.user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_viewModel.user!.profilePicture),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(labelText: 'Bio'),
                    maxLines: 3, // Ensure maxLines is properly defined here
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _viewModel.updateUserProfile(
                        _nameController.text,
                        _bioController.text,
                      );
                    },
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
    );
  }
}
