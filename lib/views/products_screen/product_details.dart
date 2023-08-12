
import 'package:emart_seller/const/const.dart';

import 'package:emart_seller/widgets/text_style.dart';


class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: fontGrey,
        title: boldText(text: "${data['p_name']}", size: 20.0, color: fontGrey),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              autoPlay: true,
              aspectRatio: 16 / 9,
              height: 350,
              viewportFraction: 1.0,
              itemCount: data['p_img'].length,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_img'][index],
                  //data['p_img'][index],
                  height: double.infinity,
                  
                  fit: BoxFit.cover,
                );
              },
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: data['p_name'], color: fontGrey, size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: data['p_category'],color: fontGrey),
                      10.widthBox,
                      normalText(text: data['p_subcategory'],color: fontGrey)
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    selectionColor: golden,
                    normalColor: textfieldGrey,
                    size: 25,
                    count: 5,
                    maxRating: 5,
                  ),
                  10.heightBox,
                  boldText(text:"${data['p_price']}".numCurrency , color: red, size: 18.0),
                  10.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Color",color: fontGrey)
                          ),
                          Row(
                            children: List.generate(
                              data['p_colors'].length,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .color(Color(data['p_colors'][index]))
                                  .roundedFull
                                  .make()
                                  .onTap(() {
                                //controller.changeColorIndex(index);
                              }),
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child:
                                boldText(text: "Quantity",color: fontGrey),
                          ),
                          normalText(text: data['p_quantity'],color: fontGrey)
                        ],
                      )
                    ],
                  ).box.padding(const EdgeInsets.all(8)).make(),
                  const Divider(),
                  20.heightBox,
                  boldText(text: "Description", color: fontGrey,),
                  10.heightBox,
                  normalText(text: data['p_description'],color: fontGrey)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
