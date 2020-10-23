import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/models/message_model.dart';
import 'package:flutter_chat_ui_starter/screens/chat_sreen.dart';

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext content, int index) {
                Message chat = messages[index];
                return GestureDetector(
                  onTap: () {
                    return Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ChatScreen(user: chat.sender)));
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    decoration: BoxDecoration(
                        color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 35.0,
                              backgroundImage: AssetImage(chat.sender.imageUrl),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(chat.sender.name,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 0.6,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(content).size.width * 0.45,
                                  child: Text(
                                    chat.text,
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              chat.time,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            chat.unread
                                ? Container(
                                    width: 40.0,
                                    height: 20.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Text(
                                      'New',
                                      style: TextStyle(fontSize: 12.0),
                                    ))
                                : Text('')
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
