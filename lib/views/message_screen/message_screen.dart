import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/message_screen/chat_screen.dart';

import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:emart_seller/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          foregroundColor: fontGrey,
          title: boldText(text: messages, size: 20.0, color: fontGrey),
        ),
        body: StreamBuilder(
          stream: StoreServices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var t = data[index]['created_on'] == null ? DateTime.now() : data[index]['created_on'].toDate();
                      var time = intl.DateFormat('h:mma').format(t);
                      return ListTile(
                        onTap: () {
                          Get.to(() => const ChatScreen());
                        },
                        leading: const CircleAvatar(
                          backgroundColor: purple,
                          child: Icon(
                            Icons.person,
                            color: white,
                          ),
                        ),
                        title: boldText(
                            text: "${data[index]['sender_name']}",
                            color: fontGrey),
                        subtitle: normalText(
                            text: "${data[index]['last_msg']}",
                            color: darkGrey),
                        trailing: normalText(
                            text: time,
                            color: darkGrey),
                      );
                    }),
                  ),
                ),
              );
            }
          },
        ));
  }
}
