import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stories/flutter_stories.dart';
import 'package:image_picker/image_picker.dart';

class Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFiles = [];
  final _momentDuration = const Duration(seconds: 5);

  Future<void> _pickImage() async {
    final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _imageFiles.add(imageFile);
      });
    }
  }

  Widget _buildStoryImage(XFile imageFile) {
    return kIsWeb ? Image.network(imageFile.path) : Image.file(File(imageFile.path));
  }

 @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        color: Colors.blue[100],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: _buildAddStoryButton(),
                ),
                SizedBox(height: 20),
                if (_imageFiles.isNotEmpty)
                  GestureDetector(
                    onTap: () => _showStory(context),
                    child: _buildStoryPreview(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddStoryButton() {
    return Container(
      decoration: _buttonDecoration(),
      width: 64.0,
      height: 64.0,
      child: Icon(CupertinoIcons.add, color: CupertinoColors.white),
    );
  }

  Widget _buildStoryPreview() {
    return Container(
      decoration: _buttonDecoration(),
      width: 64.0,
      height: 64.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: _buildStoryImage(_imageFiles.last),
      ),
    );
  }

  BoxDecoration _buttonDecoration() {
    return BoxDecoration(
      color: CupertinoColors.activeBlue,
      borderRadius: BorderRadius.circular(32.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  void _showStory(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoPageScaffold(
          child: Story(
            onFlashForward: Navigator.of(context).pop,
            onFlashBack: Navigator.of(context).pop,
            momentCount: _imageFiles.length,
            momentDurationGetter: (idx) => _momentDuration,
            momentBuilder: (context, idx) => _buildStoryImage(_imageFiles[idx]),
          ),
        );
      },
    );
  }
}