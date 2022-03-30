import 'dart:io';
import 'dart:math';

import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:intl/intl.dart';

class ChatMateRoom extends StatefulWidget {
  final String chatMateFirstName;
  final String chatMateLastName;
  final String chatMateUid;

  const ChatMateRoom(
      {Key? key,
      required this.chatMateFirstName,
      required this.chatMateLastName,
      required this.chatMateUid})
      : super(key: key);

  @override
  State<ChatMateRoom> createState() => _ChatMateRoomState();
}

class _ChatMateRoomState extends State<ChatMateRoom> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  DateTime initialDate = DateTime.now();

  TextEditingController messageTextEdittingController = TextEditingController();
  String chatRoomId = '';
  String messageId = '';
  Stream<QuerySnapshot>? messageStream;

  XFile? pickedImage;
  final ImagePicker picker = ImagePicker();
  imagePicker() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = image;
      });
    }
  }

  uploadImageToFirebaseStorage() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebase_auth.User? user = firebaseAuth.currentUser;
    FirebaseStorage storageRef = FirebaseStorage.instance;
    String uploadFileName =
        '${loggedInUser.uid},${DateFormat("yyyy-MM-dd,hh:mm:ss").format(initialDate)}.jpg';
    Reference reference =
        storageRef.ref().child('User\'s Report Images').child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(pickedImage!.path));
    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          '\t' +
          event.totalBytes.toString());
    });
    await uploadTask.whenComplete(() async {
      String uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      chatRoomId =
          getChatRoomIdByUsernames(widget.chatMateUid, '${loggedInUser.uid}');

      getAndSetMessages();
      setState(() {});
    });
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return randomString;
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addingMessage(bool sendClicked) {
    if (messageTextEdittingController.text != "") {
      String message = messageTextEdittingController.text;

      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": '${loggedInUser.firstName} ${loggedInUser.lastName}',
        "type": "text",
        "ts": lastMessageTs,
        "imgUrl": loggedInUser.image
      };

      //messageId
      if (messageId == "") {
        messageId = generateRandomString(12);
      }

      addMessage(chatRoomId, messageId, messageInfoMap).then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy":
              '${loggedInUser.firstName} ${loggedInUser.lastName}',
        };
        updateLastMessageSend(chatRoomId, lastMessageInfoMap);
        if (sendClicked) {
          // remove the text in the message input field
          messageTextEdittingController.text = "";
          // make message id blank to get regenerated on next message send
          messageId = "";
        }
      });
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  getAndSetMessages() async {
    messageStream = await getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(24),
                  bottomRight: sendByMe
                      ? const Radius.circular(0)
                      : const Radius.circular(24),
                  topRight: const Radius.circular(24),
                  bottomLeft: sendByMe
                      ? const Radius.circular(24)
                      : const Radius.circular(0),
                ),
                color: sendByMe ? Colors.blue : Colors.black,
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: const EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data!.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return chatMessageTile(
                      ds["message"],
                      '${loggedInUser.firstName} ${loggedInUser.lastName}' ==
                          ds["sendBy"]);
                })
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.chatMateFirstName} ${widget.chatMateLastName}',
          style: const TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xffcc021d),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: const Color(0xffd90824),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageTextEdittingController,
                      onChanged: (value) {
                        //addingMessage(false);
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message..",
                        hintStyle: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontSize: 12.0),
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        imagePicker();
                      },
                      child: const Icon(
                        Icons.picture_in_picture,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        addingMessage(true);
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
