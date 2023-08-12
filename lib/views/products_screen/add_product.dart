
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/product_controller.dart';
import 'package:emart_seller/views/products_screen/components/product_dropdown.dart';
import 'package:emart_seller/views/products_screen/components/product_images.dart';
import 'package:emart_seller/widgets/custom_textfield.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:emart_seller/widgets/text_style.dart';
import 'package:get/get.dart';


class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Obx(
      ()=> Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(foregroundColor: white,
          title: boldText(text: "Add product",color: white,size: 20.0),
          actions: [
          controller.isLoading.value ? loadingIndicator(circulColor: white) :  TextButton(onPressed: ()async{
              controller.isLoading(true);
              await controller.uploadImage();
              await controller.uploadProduct(context);
              Get.back();
            }, child: boldText(text: "Save",color: white))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextfield(
                  hint: "eg. BMW",
                  lable: "Product name",
                  controller: controller.pNamecontroller
                ),
                10.heightBox,
                customTextfield(lable: "Description",hint: "eg. New Product",controller: controller.pdesccontroller,isDes: true),
                10.heightBox,
                customTextfield(lable: "Price",hint: "eg. \$3000",controller: controller.ppricecontroller),
                10.heightBox,
                customTextfield(lable: "Quantity", hint: "eg. 22",controller: controller.pquantitycontroller),
                10.heightBox,
                productDropDown(hint: "Category",list: controller.categoryList,dropvalue: controller.categoryValue,controller: controller),
                10.heightBox,
                productDropDown(hint: "Subcategory",list: controller.subcategoryList,dropvalue: controller.subcategoryValue,controller: controller),
                10.heightBox,
                const Divider(color: white,),
                normalText(text: "Choose product image",color: white),
                10.heightBox,
                Obx( ()=>
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (index) => 
                    controller.pImgList[index] != null ?
                    Image.file(controller.pImgList[index],width: 100,height: 100,fit: BoxFit.cover,).onTap(() {
                      controller.pickImage(index, context);
                    }) :
                    productImage(lable: "${index+1}",).onTap(() {
                      controller.pickImage(index, context);
                    })),
                  ),
                ),
                5.heightBox,
                normalText(text: "First image will be your display image"),
                const Divider(color: white,),
                10.heightBox,
                normalText(text: "Choose product color",color: white),
                10.heightBox,
                Obx(
                  ()=> Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(9, (index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        VxBox().color(Vx.randomPrimaryColor).roundedFull.size(65, 65).make().onTap(() {
                          controller.selectedColorIndex.value = index;
                        }),
                        controller.selectedColorIndex.value == index ?
                        const Icon(Icons.done,color: white,) : const SizedBox(),
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}