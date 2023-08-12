import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;

  changeStatus({title, docID, status}) async{
    var store = firestore.collection(ordersCollection).doc(docID);
    await store.set({
      title: status
    },SetOptions(merge: true));
  }
}