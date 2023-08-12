import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;

  var profileImgPath = "".obs;
  var profileImgLink = "";
  var isLoading = false.obs;

  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  var shopNameController = TextEditingController();
  var shopaddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDesController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    if (profileImgPath.value.isNotEmpty) {
      var file = File(profileImgPath.value);
      if (file.existsSync()) {
        var filename = basename(profileImgPath.value);
        var destination = 'images/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(file);
        profileImgLink = await ref.getDownloadURL();
      } else {
        print('Error: File not found at path: ${profileImgPath.value}');
      }
    } else {
      print('Error: Empty profileImgPath');
    }
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    await store.set(
        {
          'vendor_name': name,
          'password': password,
          'imageUrl': imgUrl,
        },
        SetOptions(
          merge: true,
        ));
    isLoading(false);
  }

  changeAuthPassword(
      {email,
      TextEditingController? password,
      TextEditingController? newpassword}) async {
    final cred =
        EmailAuthProvider.credential(email: email, password: password!.text);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword!.text);
    }).catchError((error) {
      print(error.toString());
    });
  }

  updateShop({shopName,shopAddress,shopMobile,shopWebsite,shopDes}) async {
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    await store.set({
      'shop_name': shopName,
      'shop_address': shopAddress,
      'shop_mobile': shopMobile,
      'shop_website': shopWebsite,
      'shop_desc': shopDes
    },SetOptions(merge: true));
    isLoading(false);
  }
}
