import 'package:emart_seller/const/const.dart';

Widget loadingIndicator({circulColor = purpleColor}){
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circulColor),
    ),
  );
}