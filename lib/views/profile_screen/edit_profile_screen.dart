import 'dart:io';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/widgets/custom_textfield.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:emart_seller/widgets/text_style.dart';

import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
            actions: [
              controller.isLoading.value ? loadingIndicator(circulColor: white) : TextButton(
                  onPressed: () async {
                    controller.isLoading(true);
                    //if image is not selected
                    if (controller.profileImgPath.value.isNotEmpty) {
                      print(controller.oldpassController.text);
                      await controller.uploadProfileImage();
                    } else {
                      controller.profileImgLink = controller.snapshotData['imageUrl'];
                    }
                    if (controller.snapshotData['password'] == controller.oldpassController.text) {
                      print("Password match");
                      await controller.changeAuthPassword(
                        email: controller.snapshotData['email'],
                        password: controller.oldpassController,
                        newpassword: controller.newpassController,
                      );
                      await controller.uploadProfileImage();
                      print("upload profile image done");
                      await controller.updateProfile(
                          imgUrl: controller.profileImgLink,
                          name: controller.nameController.text,
                          password: controller.newpassController.text);
                      VxToast.show(context, msg: "Updated");

                    } else if(controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull){
                      
                      await controller.updateProfile(
                          imgUrl: controller.profileImgLink,
                          name: controller.nameController.text,
                          password: controller.snapshotData['password'] );
                    }
                    else{
                      VxToast.show(context, msg: "Some error accured");
                      controller.isLoading(false);
                    }
                  },
                  child: normalText(
                    text: "Save",
                  ))
            ],
            title: boldText(
              text: "Edit Profile",
              size: 20.0,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
              children: [
                controller.snapshotData['imageUrl'] == "" &&
                        controller.profileImgPath.isEmpty
                    ? Image.asset(
                        imgProduct,
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : controller.snapshotData['imageUrl'] != "" &&
                            controller.profileImgPath.isEmpty
                        ? Image.network(controller.snapshotData['imageUrl'],
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: white),
                  child: normalText(text: "Change Image", color: fontGrey),
                ),
                const Divider(
                  color: white,
                ),
                10.heightBox,
                customTextfield(
                    lable: name,
                    hint: "eg. Jay Shapariya",
                    controller: controller.nameController),
                30.heightBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: boldText(text: "Change your password")),
                10.heightBox,
                customTextfield(
                    lable: password,
                    hint: passwordHint,
                    controller: controller.oldpassController),
                10.heightBox,
                customTextfield(
                    lable: "Confirm Password",
                    hint: passwordHint,
                    controller: controller.newpassController)
              ],
            ),
          
        ),
      ),
    );
  }
}
