import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';

import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/orders_screen/order_details.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart' as intl;
import 'package:emart_seller/widgets/appbar_widget.dart';
import 'package:emart_seller/widgets/text_style.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: appbarWidget(title: orders),
        body: StreamBuilder(
            stream: StoreServices.getOrders(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } 
              else {
                var data = snapshot.data!.docs;
                
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                        data.length,
                        (index) {
                          var t = data[index]['order_date'].toDate();
                          return ListTile(
                          onTap: () {
                            
                            Get.to(() => OrderDetails(data: data[index]));
                          },

                          //tileColor: lightGrey,

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          title: boldText(
                            text: "${data[index]['order_code']}",
                            color: purpleColor,
                          ),
                          //tileColor: textfieldGrey,
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month),
                                  10.widthBox,
                                  boldText(
                                      text: intl.DateFormat()
                                          .add_yMd()
                                          .format(t),
                                      color: fontGrey),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.fire_truck),
                                  10.widthBox,
                                  boldText(text: unpaid, color: red),
                                ],
                              )
                              //normalText(text: "\$400",color: darkGrey),
                            ],
                          ),
                          trailing: boldText(text: "${data[index]['total_ammount']}".numCurrency, color: darkGrey),
                        )
                            .box
                            .white
                            .outerShadow
                            .margin(const EdgeInsets.only(bottom: 4))
                            .make();}
                      ),
                    ),
                  ),
                );
              }
            },),);
  }
}
