import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/images.dart';

import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/widgets/appbar_widget.dart';
import 'package:emart_seller/widgets/dasbord_button.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:emart_seller/widgets/text_style.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(title: dashbord),
        body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator(circulColor: green);
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy(
                (a, b) =>
                    b['p_wishlist'].length.compareTo(a['p_wishlist'].length),
              );
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dasbordButton(context,
                            title: products, count: "${data.length}", icon: icProducts),
                        dasbordButton(context,
                            title: orders, count: "79", icon: icOrders)
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dasbordButton(context,
                            title: rating, count: "2", icon: icStar),
                        dasbordButton(context,
                            title: totalsales, count: "152", icon: icOrders)
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    boldText(text: popularProduct, size: 16.0, color: darkGrey),
                    20.heightBox,
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: List.generate(
                            data.length,
                            (index) => data[index]['p_wishlist'].length == 0
                                ? const SizedBox()
                                : ListTile(
                                    onTap: () {
                                      Get.to(() => ProductDetails(
                                            data: data[index],
                                          ));
                                    },
                                    leading: Image.network(
                                      data[index]['p_img'][0],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    title: boldText(
                                      text: data[index]['p_name'],
                                      color: fontGrey,
                                    ),
                                    subtitle: normalText(
                                        text: "${data[index]['p_price']}"
                                            .numCurrency,
                                        color: darkGrey),
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
