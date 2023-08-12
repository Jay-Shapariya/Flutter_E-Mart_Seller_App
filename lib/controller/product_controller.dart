import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/controller/home_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  
  var isLoading = false.obs;
  
  var pNamecontroller = TextEditingController();
  var pdesccontroller = TextEditingController();

  var ppricecontroller = TextEditingController();

  var pquantitycontroller = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImgList = RxList<dynamic>.generate(3, (index) => null);
  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;
  var selectedColorIndex = 0.obs;
  var pImgLink = [];

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategories() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubcategories(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImgList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    pImgLink.clear();
    for (var item in pImgList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImgLink.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_colors': FieldValue.arrayUnion([Colors.red.value,Colors.brown.value]),
      'p_description': pdesccontroller.text,
      'p_img': FieldValue.arrayUnion(pImgLink),
      'p_name': pNamecontroller.text,
      'p_price': ppricecontroller.text,
      'p_quantity': pquantitycontroller.text,
      'p_rating': "3.2",
      'p_seller': Get.find<HomeController>().username,
      'p_wishlist': FieldValue.arrayUnion([]),
      'vendor_id': currentUser!.uid,
      'featured_id': ''
    });
    isLoading(false);
    VxToast.show(context, msg: "Product uploaded"); 
  }

  addFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': true,
    }, SetOptions(merge: true));
  }
  removeFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': '',
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();

  }
}
