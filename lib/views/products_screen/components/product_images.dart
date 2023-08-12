import 'package:emart_seller/const/const.dart';


Widget productImage({required lable,onpressed}){
  return "$lable".text.color(fontGrey).size(16.0).bold.makeCentered().box.roundedSM.size(100, 100).color(lightGrey).make();
}