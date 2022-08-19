import 'dart:async';

import 'package:cabby/rider/Assistants/assistantMethods.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/available_model.dart';
import 'package:cabby/rider/Models2/messagemodel.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/widget/shimmer.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Chat extends StatefulWidget {
  final AvailableModel availableModel;
  final RiderUserModel? userModel;
  const Chat({
    Key? key,
    required this.availableModel,
    this.userModel,
  }) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  String? text;
  TextEditingController? _controller;
  final List<String> avatars = [defaultImg!, defaultImg!];
  bool load = false;
  final rand = Random();
  List message = [];
  var messageCOunt = 0;
  Timer? timer;

  bool loading = false;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) {
      checkMessage();
      // print('checked');
    });
    fetchMessage();
    _controller = TextEditingController();
  }

  Future<List<MessageModel>> getData() async {
    // print(widget.transaction);
    var url = '${globalUrl}fetch-chat/${widget.availableModel.id}';
    // print(url);

    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    return body['chat'].map<MessageModel>(MessageModel.fromJson).toList();
  }

  Future<List<MessageModel>> getData2() async {
    // print("object");
    return message.map<MessageModel>(MessageModel.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "",
          style: Config.style(FontWeight.w500, textColor, 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: pColor,
              child: IconButton(
                  onPressed: () => call(),
                  icon: const Icon(
                    Icons.call,
                    color: Colors.black,
                  )),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<MessageModel>>(
              future: getData(),
              builder: (context, AsyncSnapshot snapshot) {
                final result = snapshot.data;
                if (snapshot.hasError) {
                  return const EmptyTab();
                }

                if (!snapshot.hasData) {
                  return const Text('');
                }
                if (snapshot.data.length < 1) {
                  return const EmptyTab();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final model = result[index];

                    // MessageModel m = messages[index];
                    if (model.senderId == widget.userModel!.id) {
                      // print(m)
                      return _buildMessageRow(model, current: true);
                    } else {
                      return _buildMessageRow(model, current: false);
                    }
                  },
                );
              },
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Container _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: "Aa"),
              onEditingComplete: _save,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: pColor,
            onPressed: _save,
          )
        ],
      ),
    );
  }

  _save() async {
    if (_controller!.text.isEmpty) return;
    FocusScope.of(context).requestFocus(FocusNode());
    // final chat = MessageModel(
    //     message: _controller!.text,
    //     senderId: "93adab4a-7b84-45ff-8337-ad3fff2597b4",
    //     receiverId: "5c7eb7e2-3d96-4939-a550-6a9ded7fe3ba",
    //     rideId: "${widget.availableModel.id}");
    var url = '${globalUrl}add-chat';
    var data = {
      "message": _controller!.text,
      "senderId": widget.userModel!.id,
      "receiverId": widget.availableModel.driverId,
      "rideId": "${widget.availableModel.id}"
    };
    var response = await AssistantMethods.getRequest(url, data);
    setState(() {
      load = true;
      // message.add(chat);
      //   _controller!.clear();
    });
    if (!mounted) return;
    // print(message);go
    goTo(
        Chat(
                      userModel: widget.userModel,

          availableModel: widget.availableModel,
        ),
        context);
  }

  Row _buildMessageRow(MessageModel message, {required bool current}) {
    return Row(
      mainAxisAlignment:
          current ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          current ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: current ? 30.0 : 20.0),
        if (!current) ...[
          CircleAvatar(
            backgroundImage: NetworkImage(
              current ? avatars[0] : avatars[1],
            ),
            radius: 20.0,
          ),
          const SizedBox(width: 5.0),
        ],

        ///Chat bubbles
        Container(
          padding: const EdgeInsets.only(
            bottom: 5,
            right: 5,
          ),
          child: Column(
            crossAxisAlignment:
                current ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  minHeight: 40,
                  maxHeight: 250,
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  minWidth: MediaQuery.of(context).size.width * 0.1,
                ),
                decoration: BoxDecoration(
                  color: current ? textColor : pColor,
                  borderRadius: current
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, bottom: 5, right: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: current
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          message.message!,
                          style: TextStyle(
                            color: current ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.done_all,
                        color: Colors.white,
                        size: 14,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                formatTripDate(message.createdAt!),
                style: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.5)),
              )
            ],
          ),
        ),
        if (current) ...[
          const SizedBox(width: 5.0),
          CircleAvatar(
            backgroundImage: NetworkImage(
              current ? avatars[0] : avatars[1],
            ),
            radius: 10.0,
          ),
        ],
        SizedBox(width: current ? 20.0 : 30.0),
      ],
    );
  }

  call() {}

  Future<List<MessageModel>> fetchMessage() async {
    var url = '${globalUrl}fetch-chat/${widget.availableModel.id}';
    // print(url);

    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);
    setState(() {
      load = true;
      message = body['chat'];
      messageCOunt = body['count'];
    });
    // print(messageCOunt);
    // print(body);
    return body['chat'].map<MessageModel>(MessageModel.fromJson).toList();
  }

  void checkMessage() async {
    var url = '${globalUrl}check-chat/${widget.availableModel.id}';
    // print("check");

    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);
    // print(body);
    // print(messageCOunt);
    if (!mounted) return;

    if (messageCOunt != body) {
      setState(() {
        messageCOunt = body;
      });

      goTo(
          Chat(
            availableModel: widget.availableModel,
            userModel: widget.userModel,
          ),
          context);
    }
  }
}
