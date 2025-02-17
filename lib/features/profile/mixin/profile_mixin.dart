import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/features/profile/view/profile.dart';
import 'package:path_provider/path_provider.dart';

mixin ProfileMixin on State<ProfileView> {
  late final ImagePicker picker;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
    SecureStorage.instance.readSecureData("profileImage").then((value) {
      setState(() {
        imagePath = value;
        debugPrint("imagePath: $imagePath");
      });
    });
  }

  bool isValidImagePath(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return false;
    try {
      final file = File(imagePath);
      return file.existsSync() && file.lengthSync() > 0;
    } catch (e) {
      debugPrint('Image validation error: $e');
      return false;
    }
  }

  List<Map<String, dynamic>> getProfileList(BuildContext context) {
    List<Map<String, dynamic>> profileList = [
      {
        "title": "Hesap Ayarları",
        "icon": IconManager.instance.customIcon(Icons.edit_outlined, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
        "onTap": (user) {
          context.push(RouterManager.profileEdit, extra: user);
        },
      },
      {
        "title": "Rençber Hakkında",
        "icon": IconManager.instance.customIcon(Icons.info_outline, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
        "onTap": (user) {
          context.push(RouterManager.about);
        },
      },
      {
        "title": "Bildirim Tercihleri",
        "icon": IconManager.instance.customIcon(Icons.notifications, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
        "onTap": (user) {
          context.push(RouterManager.notificationSetting, extra: user);
        },
      },
      {
        "title": "KVKK",
        "icon": IconManager.instance.customIcon(Icons.lock, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
        "onTap": (user) {
          context.push(RouterManager.kvkk);
        },
      },
      // {
      //   "title": "Çıkış Yap",
      //   "icon": IconManager.instance.customIcon(Icons.logout, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
      //   "onTap": () {},
      // },
    ];
    return profileList;
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024, // Resim boyutunu sınırlayalım
        maxHeight: 1024,
        imageQuality: 85, // Kaliteyi ayarlayalım
      );

      if (pickedFile != null) {
        final File pickedImage = File(pickedFile.path);
        if (!await pickedImage.exists()) {
          debugPrint('Picked image does not exist');
          return;
        }

        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedImagePath = '${appDir.path}/$fileName';

        // Önce varolan dosyayı kontrol edelim ve silelim
        final savedImage = File(savedImagePath);
        if (await savedImage.exists()) {
          await savedImage.delete();
        }

        // Yeni dosyayı kopyalayalım
        await pickedImage.copy(savedImagePath);

        // Kopyalanan dosyanın varlığını kontrol edelim
        if (!await File(savedImagePath).exists()) {
          debugPrint('Failed to save image');
          return;
        }

        setState(() {
          imagePath = savedImagePath;
        });
        await SecureStorage.instance.writeSecureData("profileImage", savedImagePath);
        debugPrint('Image saved successfully at: $savedImagePath');
      }
    } catch (e) {
      debugPrint('Error picking/saving image: $e');
    }
  }
}
