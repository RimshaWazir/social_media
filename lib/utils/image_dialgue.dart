import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/utils/media_query.dart';

Future<void> imageDialogue(BuildContext context,
    {required Function(XFile file) onSelect}) async {
  showBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: screenWidth(context),
          height: screenHeight(context) * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Select Picker"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        final img =
                            await pickImage(imageSource: ImageSource.camera);
                        if (img != null) {
                          onSelect.call(img);
                        }
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.blue,
                        size: 40,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () async {
                        final img =
                            await pickImage(imageSource: ImageSource.gallery);
                        if (img != null) {
                          onSelect.call(img);
                        }
                      },
                      icon: const Icon(
                        Icons.browse_gallery,
                        color: Colors.purple,
                        size: 40,
                      )),
                ],
              ),
            ],
          ),
        );
      });
}

Future<XFile?> pickImage({required ImageSource imageSource}) async {
  final ImagePicker _picker = ImagePicker();
  final img = await _picker.pickImage(source: imageSource);
  return img;
}
