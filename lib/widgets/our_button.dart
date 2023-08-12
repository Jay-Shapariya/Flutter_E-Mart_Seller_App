import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widgets/text_style.dart';

Widget ourButton({title, color = purpleColor, onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(12)),
    child: normalText(text: title, size: 16.0),
  );
}
