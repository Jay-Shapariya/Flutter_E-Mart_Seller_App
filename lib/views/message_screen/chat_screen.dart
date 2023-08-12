import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/chat_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/message_screen/components/sender_bubble.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:get/get.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: "${controller.friendName}".text.size(20).color(darkGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(color: purple,),
            Expanded(
              child: StreamBuilder(stream: StoreServices.getChatMessages(controller.chatDocId.toString()
            
              ),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot) {
                if(!snapshot.hasData){
                  return Center(
                    child: loadingIndicator(),
                  );
                }
                else if(snapshot.data!.docs.isEmpty){
                  return Center(
                    child: "Send a message".text.color(darkGrey).make(),
                  );
                }
                else{
                  return ListView(
                    children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                      var data = snapshot.data!.docs[index];
                      return Align(
                        alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                        child: senderBubble(data));
                    }).toList()
                  );
                }
              } 
              )
            ),
            10.heightBox,
            Row(
              children: [
                Obx(
                  ()=> 
                  controller.isLoading.value ? Center(child: loadingIndicator(),) 
                  : Expanded(
                    child: TextField(
                      controller: controller.msgController,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textfieldGrey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textfieldGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                )
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}
