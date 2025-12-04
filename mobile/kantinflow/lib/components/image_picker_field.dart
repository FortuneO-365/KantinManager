import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatelessWidget {
  final XFile? selectedImage;
  final void Function(XFile? file) onImageSelected;

  const ImagePickerField({
    super.key,
    required this.selectedImage,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue.shade300,
            width: 2,
          ),
        ),
        child: selectedImage == null
            ? _buildUploadPlaceholder()
            : _buildImagePreview(context),
      ),
    );
  }

  // Placeholder before selecting an image
  Widget _buildUploadPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.blue),
          SizedBox(height: 10),
          Text(
            "Upload Product Image",
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
          Text(
            "PNG, JPG up to 5MB",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Preview after selecting an image
  Widget _buildImagePreview(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(selectedImage!.path),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        // Remove button
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => onImageSelected(null), // remove image
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  // Bottom sheet for picking image
  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt_outlined),
                title: Text("Take Photo"),
                onTap: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.camera);
                  onImageSelected(pickedFile);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library_outlined),
                title: Text("Choose from Gallery"),
                onTap: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  onImageSelected(pickedFile);
                  Navigator.pop(context);
                },
              ),
              if (selectedImage != null)
                ListTile(
                  leading: Icon(Icons.delete_outline, color: Colors.red),
                  title: Text("Remove Image", style: TextStyle(color: Colors.red)),
                  onTap: () {
                    onImageSelected(null);
                    Navigator.pop(context);
                  },
                ),
              SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
