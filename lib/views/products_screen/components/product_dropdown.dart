import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/product_controller.dart';
import 'package:emart_seller/widgets/text_style.dart';
import 'package:get/get.dart';

Widget productDropDown(
    {hint,
    required List<String> list,
    dropvalue,
    required ProductController controller}) {
  return Obx(
    ()=> DropdownButtonHideUnderline(
            child: DropdownButton(
                hint: normalText(text: hint, color: darkGrey),
                value: dropvalue.value == '' ? null : dropvalue.value,
                isExpanded: true,
                items: list.map((e) {
                  return DropdownMenuItem(
                      value: e, child: e.toString().text.make());
                }).toList(),
                onChanged: (newvalue) {
                  if (hint == "Category") {
                    controller.subcategoryValue.value = '';
                    controller.populateSubcategories(newvalue.toString());
                  }
  
                  dropvalue.value = newvalue.toString();
                }))
        .box
        .white
        .roundedSM
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .make(),
  );
}
