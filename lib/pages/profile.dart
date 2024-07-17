import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verademo_dart/controllers/profile_controller.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';
import 'package:verademo_dart/widgets/credentials_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verademo_dart/widgets/profile_image.dart';
import 'package:verademo_dart/widgets/user_field.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final username = VSharedPrefs().username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: VConstants.pagePadding,
          child: Column(
            children: [
              _updateProfileForm(),
              const SizedBox(height: VConstants.textFieldSpacingMed * 2),
              _hecklersButton(),
              const SizedBox(height: VConstants.textFieldSpacing / 2),
              _historyButton(),
            ],
          )
        )
      )
    );
  }

  SizedBox _historyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text("History"),
      ),
    );
  }

  SizedBox _hecklersButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text("Hecklers"),
      ),
    );
  }

  Form _updateProfileForm() {
    final controller = ProfileController();

    controller.username.text = VSharedPrefs().username ?? "";

    return Form(
      child: Column(
        children: [
          _profileImage(),
          const SizedBox(height: VConstants.textFieldSpacing * 2),
          VUserField("Real Name", controller: controller.realName),
          const SizedBox(height: VConstants.textFieldSpacingMed),
          VUserField("Blab Name", controller: controller.blabName),
          const SizedBox(height: VConstants.textFieldSpacingMed),
          VUserField("Username", controller: controller.username),
          const SizedBox(height: VConstants.textFieldSpacingMed),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Update Profile"),
            ),
          )
        ],
      ),
    );
  }

  Row _profileImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // CircleAvatar(
        //   foregroundImage:  File('assets/images/$username.png').existsSync() ? AssetImage('assets/images/$username.png') : const AssetImage('assets/images/default_profile.png'),
        //   backgroundImage: const AssetImage('assets/images/default_profile.png'),
        //   radius: 48,
        // ),
        VAvatar(VSharedPrefs().username),
        const SizedBox(width: 30),
        _profileImageActions()
      ]
    );
  }
  

  Expanded _profileImageActions() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  final dir = await getApplicationDocumentsDirectory();
                  final File newFile = File("${dir.path}/$username.png");
                  if (!newFile.existsSync()) {
                    newFile.create(recursive: true);
                  }
                  await File(image.path).copy("${dir.path}/$username.png");
                }

              },
              child: const Text("Change Profile Picture")
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                print(await getApplicationDocumentsDirectory());
                final File image = await File('assets/images/$username.png').exists() ? File('assets/images/$username.png') : File('assets/images/default_profile.png');
                final directory = await getDownloadsDirectory();
                if (!File("${directory?.path}/$username.png").existsSync()) {
                  File('${directory?.path}/$username.png').create(recursive: true);
                }
                // final File image = await rootBundle.load('assets/images/$username.png');

                await image.copy("${directory?.path}/$username.png");
              },
              child: const Text("Download Current Image")
            ),
          ),
        ]
      )
    );
  }
}