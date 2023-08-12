
import 'package:emart_seller/const/const.dart';

import 'package:emart_seller/widgets/text_style.dart';

Widget dasbordButton(context,{title,count,icon}){
  var size = MediaQuery.of(context).size;
  return Row(
              children: [
                Expanded(child: Column(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: title,size: 18.0),
                    boldText(text: count,size: 20.0)
                  ],
                )),
                Image.asset(
                  icon,
                  width: 40,
                  color: white,
                )
              ],
            )
                .box
                .rounded
                .outerShadowMd
                .color(purple)
                .size(size.width * 0.4, 80)
                .padding(const EdgeInsets.all(8))
                .make();
}