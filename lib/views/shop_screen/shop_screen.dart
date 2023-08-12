import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/widgets/custom_textfield.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:emart_seller/widgets/text_style.dart';

import 'package:get/get.dart';

class ShopSetting extends StatelessWidget {
  const ShopSetting({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circulColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      
                     
                      await controller.updateShop(
                          shopName: controller.shopNameController.text,
                          shopAddress: controller.shopaddressController.text,
                          shopMobile: controller.shopMobileController.text,
                          shopWebsite: controller.shopWebsiteController.text,
                          shopDes: controller.shopDesController.text);
                          VxToast.show(context, msg: "Updated");
                    },
                    child: normalText(text: "Save"))
          ],
          title: boldText(
            text: "Shop Settings",
            size: 20.0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextfield(
                  lable: "Shop Name",
                  hint: nameHint,
                  controller: controller.shopNameController),
              10.heightBox,
              customTextfield(
                  lable: address,
                  hint: shopAddressHint,
                  controller: controller.shopaddressController),
              10.heightBox,
              customTextfield(
                  lable: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopMobileController),
              10.heightBox,
              customTextfield(
                  lable: website,
                  hint: shopWebsiteHint,
                  controller: controller.shopWebsiteController),
              10.heightBox,
              customTextfield(
                  lable: description,
                  hint: shopDescHint,
                  controller: controller.shopDesController,
                  isDes: true)
            ],
          ),
        ),
      ),
    );
  }
}
