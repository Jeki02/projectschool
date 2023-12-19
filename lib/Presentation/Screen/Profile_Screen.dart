import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_school/Data/Models/Model_User.dart';
import 'package:flutter_school/Generate/generated/locale_keys.g.dart';
import 'package:flutter_school/Generate/translation.dart';
import 'package:flutter_school/Presentation/Bloc/Authentication/Authentication_bloc.dart';
import 'package:flutter_school/Presentation/Bloc/Authentication/Authentication_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    if (kIsWeb) {
      String? imageDataString = prefs.getString('user_image_data');
      if (imageDataString != null) {
        _imageData = Uint8List.fromList(imageDataString.codeUnits);
      }
    } else {
      String? imagePath = prefs.getString('user_image_path');
      if (imagePath != null) {
        _imageData = await File(imagePath).readAsBytes();
      }
    }
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageData = await pickedFile.readAsBytes();
      setState(() {
        _imageData = imageData;
      });
      final prefs = await SharedPreferences.getInstance();
      if (kIsWeb) {
        String imageDataString = String.fromCharCodes(imageData);
        await prefs.setString('user_image_data', imageDataString);
      } else {
        String imagePath = pickedFile.path;
        await prefs.setString('user_image_path', imagePath);
      }
    }
  }
@override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return _buildUserProfile(state.user);
        } else if (state is AuthenticationLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text('Не удалось загрузить данные пользователя'));
        }
      },
    );
  }

  Widget _buildUserProfile(UserModel user) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.login.tr()),
         actions: [
          Lang()
        ],
      ),
      body: Container(
        color: Colors.blue[100],
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: _imageData != null
                    ? Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(_imageData!),
                          ),
                        ),
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey,
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Имя: ${user.name}', style: TextStyle(fontSize: 16)),
                          Text('Почта: ${user.email}', style: TextStyle(fontSize: 16)),
                          Text('Класс: 11', style: TextStyle(fontSize: 16)),
                          Text('Возраст: 18', style: TextStyle(fontSize: 16)),
                          Text('Адрес: Abay street, 8a', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Расписание', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Monday            Thuesday            Wednesdey', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('English             Math               Biology ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Biology            English            Chemistry', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Physic             Geometry             Math', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Chemistry          Biology             Geometry', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Geometry           Physic              English', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Оценки', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Math:5', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('English:4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Biology:4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Physic:5', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Chemistry:5', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Geometry:4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}