import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widgets/text_style.dart';

Widget orderPlaceDetail({t1, t2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: t1,color: purpleColor,),
            boldText(text: d1,color: red)
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: t2,color: purpleColor,),
            boldText(text: d2,color: fontGrey)
            ],
          ),
        )
      ],
    ),
  );
}
