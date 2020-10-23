import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/models/message_model.dart';
import 'package:flutter_chat_ui_starter/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _buildMessageComposer() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.photo),
              iconSize: 30.0,
              color: Theme.of(context).primaryColor,
              onPressed: () {}),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              onChanged: (value) {
                print('$value');
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              iconSize: 30.0,
              color: Theme.of(context).primaryColor,
              onPressed: () {})
        ],
      ),
    );
  }

  Widget _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: isMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: BoxDecoration(
          color: isMe ? Color(0xFFFFEFEE) : Theme.of(context).accentColor,
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                )
              : BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            message.text,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey),
          )
        ],
      ),
    );

    if (isMe) {
      return msg;
    }

    return Row(
      children: [
        msg,
        IconButton(
            icon: message.isLiked
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_outline),
            iconSize: 30.0,
            color: message.isLiked
                ? Theme.of(context).primaryColor
                : Colors.blueGrey,
            onPressed: () {})
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {})
        ],
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = messages[index];
                      bool isMe = message.sender.id == currentUser.id;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
