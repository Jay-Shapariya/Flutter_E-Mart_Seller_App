import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widgets/text_style.dart';

Widget customTextfield({lable,hint,controller, isDes = false}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: white),
    maxLines: isDes ? 4 : 1 ,
    decoration: InputDecoration(
      label: normalText(text:lable),
      hintText: hint,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white)),
      hintStyle: const TextStyle(color: lightGrey),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white)),
    ),
  );
}
