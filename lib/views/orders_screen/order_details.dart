import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/order_controller.dart';
import 'package:emart_seller/views/orders_screen/components/order_place.dart';
import 'package:emart_seller/widgets/our_button.dart';
import 'package:emart_seller/widgets/text_style.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key,this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrderController>();
  @override
  void initState() {
    
    super.initState();
    controller.confirmed.value = widget.data['order_confirm'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          foregroundColor: fontGrey,
          title: boldText(text: "Order Details", color: fontGrey, size: 20.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child:
                ourButton(title: "Confirm order", color: green, onPressed: () {
                  controller.confirmed(true);
                  controller.changeStatus(title: 'order_confirm',status: true,docID: widget.data.id);
                }),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                     
                      boldText(text: "Order status:",color: fontGrey,size: 16.0),
                      
                      SwitchListTile(
                        value: true,
                        onChanged: (value) {
                          
                        },
                        title: boldText(text: "Placed", color: fontGrey),
                        activeColor: green,
                      ),
                      SwitchListTile(
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                          controller.changeStatus(title: 'order_confirm',status: value ,docID: widget.data.id);
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                        activeColor: green,
                      ),
                      SwitchListTile(
                        value: controller.onDelivery.value,
                        onChanged: (value) {
                          controller.onDelivery.value= value;
                          controller.changeStatus(title: 'order_on_delivery',status: value,docID: widget.data.id);
                        },
                        title: boldText(text: "On delivery", color: fontGrey),
                        activeColor: green,
                      ),
                      SwitchListTile(
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                          controller.changeStatus(title: 'order_delivered',status: value,docID: widget.data.id);
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                        activeColor: green,
                      ),
                    ],
                  )
                      .box
                      .roundedSM
                      .shadowMd
                      .white
                      .padding(const EdgeInsets.all(8))
                      .border(color: lightGrey)
                      .roundedSM
                      .margin(const EdgeInsets.only(bottom: 4))
                      .make(),
                ),
                10.heightBox,
                Column(
                  children: [
                    orderPlaceDetail(
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                        t1: "Order code",
                        t2: "Shipping method"),
                    orderPlaceDetail(
                        //d1: data['order_date'].toDate(),
                        d1: intl.DateFormat().add_yMd().format(widget.data['order_date'].toDate()),
                        d2: "${widget.data['payment_method']}",
                        t1: "Order date",
                        t2: "Payment method"),
                    orderPlaceDetail(
                        d1: "Unpaid",
                        d2: 'Order placed',
                        t1: "Payment status",
                        t2: "Order status"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.heightBox,
                              5.heightBox,
                              boldText(
                                  text: "shipping adddress", color: purpleColor),
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by_city']}".text.make(),
                              "${widget.data['order_by_state']}".text.make(),
                              "${widget.data['order_by_postal']}".text.make(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 145,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(text: "Total ammount", color: purpleColor),
                              boldText(text: "${widget.data['total_ammount']}".numCurrency, color: red, size: 16.0),
                              
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
                    .box
                    .roundedSM
                    .shadowMd
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                const Divider(),
                10.heightBox,
                boldText(text: "Ordered Products", color: fontGrey, size: 16.0),
                20.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(widget.data['orders'].length, (index) {
                    //var order = "data['orders'][index]";
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlaceDetail(
                            t1: "${widget.data['orders'][index]['title']}",
                            t2: "${widget.data['orders'][index]['tprice']},",
                            d1: "${widget.data['orders'][index]['qyt']}x",
                            d2: "Refundable",
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              width: 30,
                              height: 20,
                              color: Color(widget.data['orders'][index]['color']),
                            ),
                          ),
                          const Divider(),
                        ]);
                  }).toList(),
                )
                    .box
                    .roundedSM
                    .shadowMd
                    .white
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
