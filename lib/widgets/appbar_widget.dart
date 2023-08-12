import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget({title}){
  return AppBar(
    backgroundColor: white,
        automaticallyImplyLeading: false,
        title: boldText(text: title, size: 20.0, color: darkGrey),
        actions: [
          Center(
              child: boldText(
                  text: intl.DateFormat("EEE, MMM d, ''yy")
                      .format(DateTime.now()),
                  color: purple)),
          10.widthBox
        ],
      );
}