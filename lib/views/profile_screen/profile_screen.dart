import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/controller/auth_controller.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/message_screen/message_screen.dart';
import 'package:emart_seller/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_seller/views/shop_screen/shop_screen.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:emart_seller/widgets/text_style.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                
                Get.to(() => EditProfileScreen(username: controller.snapshotData['vendor_name'],));
              },
              icon: const Icon(Icons.edit),
            ),
            5.widthBox,
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signoutMethod(context);
                  Get.offAll(() => const LoginScreen());
                },
                child: normalText(
                  text: logout,
                ))
          ],
          title: boldText(
            text: settings,
            size: 20.0,
          )),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(circulColor: white);
          } 
          else if(snapshot.data!.docs.isEmpty){
            return normalText(text: "Null");
          }
          else {
            controller.snapshotData = snapshot.data!.docs[0];
            return Column(
              children: [
                ListTile(
                  title: boldText(text: "${controller.snapshotData['vendor_name']}", size: 16.0),
                  subtitle: normalText(text: "${controller.snapshotData['email']}"),
                  leading: controller.snapshotData['imageUrl'] == ""
                              ? Image.asset(
                                  imgProduct,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  controller.snapshotData['imageUrl'],
                                  width: 100,
                                  
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          
                ),
                const Divider(),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: List.generate(
                        profileButtonTitles.length,
                        (index) => ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(() => const ShopSetting());
                                  case 1:
                                    Get.to(() => const MessageScreen());
                                }
                              },
                              leading: Icon(
                                profileButtonIcons[index],
                                color: white,
                              ),
                              title: normalText(
                                  text: profileButtonTitles[index], size: 16.0),
                            )),
                  ),
                )
              ],
            );
          }
        },
      ),
      
    );
  }
}
