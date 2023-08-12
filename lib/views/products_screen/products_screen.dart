import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/product_controller.dart';

import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products_screen/add_product.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/widgets/appbar_widget.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';

import 'package:emart_seller/widgets/text_style.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () async{
              await controller.getCategories();
              controller.populateCategories();
              Get.to(() => const AddProduct());
            },
            backgroundColor: purple,
            child: const Icon(Icons.add)),
        appBar: appbarWidget(title: products),
        body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator(circulColor: green);
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                      data.length,
                      (index) => ListTile(
                        onTap: () {
                          Get.to(() => ProductDetails(data: data[index]));
                        },
                        leading: Image.network(
                          data[index]['p_img'][0],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: boldText(
                          text: "${data[index]['p_name']}",
                          color: fontGrey,
                        ),
                        subtitle: Row(
                          children: [
                            normalText(text: "${data[index]['p_price']}".numCurrency, color: red),
                            10.widthBox,
                            normalText(text: data[index]['is_featured'] == true ? featured : "", color: green)
                          ],
                        ),
                        trailing: VxPopupMenu(
                          arrowSize: 0.0,
                          clickType: VxClickType.singleClick,
                          child: const Icon(Icons.more_vert_outlined),
                          menuBuilder: () => Column(
                            children: List.generate(
                              popupMenuTitles.length,
                              (i) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(popupMenuIcons[i],
                                    color: data[index]['featured_id'] == currentUser!.uid && i == 0 ? green : darkGrey,
                                    ),
                                    10.widthBox,
                                    normalText(
                                        text: data[index]['featured_id'] == currentUser!.uid && i == 0 ? 'Remove feature' : popupMenuTitles[i],
                                        color: darkGrey,
                                    )
                                  ],
                                ).onTap(() {

                                  switch (i) {
                                    case 0:
                                      if(data[index]['is_featured'] == true){
                                    controller.removeFeatured(data[index].id);
                                    
                                    VxToast.show(context, msg: 'Removed');

                                  }else{
                                    controller.addFeatured(data[index].id);
                                    
                                    VxToast.show(context, msg: 'Added');
                                  }
                                      
                                      break;
                                    case 1:
                                      break;
                                    case 2:
                                      controller.removeProduct(data[index].id);
                                      VxToast.show(context, msg: "Product removed");
                                      break;  
                                    default:
                                  }
                                }),
                              ),
                            ),
                          )
                              .box
                              .white
                              .width(200)
                              .rounded
                              .outerShadow
                              .padding(const EdgeInsets.all(8))
                              .make(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),);
  }
}
