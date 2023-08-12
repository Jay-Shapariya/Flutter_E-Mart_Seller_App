import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/controller/auth_controller.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:emart_seller/widgets/our_button.dart';
import 'package:emart_seller/widgets/text_style.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.heightBox,
            normalText(text: welcome, size: 18.0),
            20.heightBox,
            Row(
              children: [
                Image.asset(
                  icLogo,
                  width: 70,
                  height: 70,
                )
                    .box
                    .outerShadowSm
                    .border(color: white)
                    .color(purple)
                    .padding(const EdgeInsets.all(8))
                    .rounded
                    .make(),
                10.widthBox,
                boldText(text: appname, size: 20.0)
              ],
            ),
            40.heightBox,
            normalText(text: loginTo, size: 18.0),
            10.heightBox,
            Obx(
              () => Column(
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      hintText: emailHint,
                      filled: true,
                      labelText: email,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email,
                        color: purple,
                      ),
                    ),
                  ),
                  10.heightBox,
                  TextFormField(
                    obscureText: true,
                    controller: controller.passwordController,
                    decoration: const InputDecoration(
                      hintText: passwordHint,
                      labelText: password,
                      filled: true,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: purple,
                      ),
                    ),
                  ),
                  10.heightBox,
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: normalText(
                              text: forgotPassword, color: Colors.blue))),
                  15.heightBox,
                  SizedBox(
                    width: context.screenWidth - 100,
                    child: controller.isLoging.value
                        ? const Center(child: CircularProgressIndicator())
                        : ourButton(
                            title: login,
                            onPressed: () async {
                              // Get.to(const Home());
                              controller.isLoging(true);
                              await controller
                                  .loginMethod(context: context)
                                  .then(
                                (value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: "Logged in");
                                    controller.isLoging(false);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isLoging(false);
                                  }
                                },
                              );
                            },
                            color: purple),
                  )
                ],
              )
                  .box
                  .outerShadowMd
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(8))
                  .make(),
            ),
            10.heightBox,
            Center(
                child: normalText(
              text: anyProblem,
            )),
            const Spacer(),
            Center(child: normalText(text: credit)),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
