import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/ChatRoom/chat_mate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'search_screen.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatRooms> createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  Stream<QuerySnapshot>? chatRoomsStream;
  String chatRoomId = '';

  Future<Stream<QuerySnapshot>> getChattingRooms() async {
    String myUserId = '${loggedInUser.uid}';
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myUserId)
        .snapshots();
  }

  getChatRooms() async {
    chatRoomsStream = await getChattingRooms();
    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return ChatRoomListTile(
                      lastMessage: ds["lastMessage"],
                      chatRoomId: ds.id,
                      myUserId: '${loggedInUser.uid}');
                })
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());

      getChatRooms();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat Rooms',
          style: TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xffcc021d),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffcc021d),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SearchScreen()));
        },
        child: const Icon(
          Icons.search,
          size: 30,
        ),
      ),
      body: chatRoomsList(),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage;
  final String chatRoomId;
  final String myUserId;

  const ChatRoomListTile(
      {Key? key,
      required this.lastMessage,
      required this.chatRoomId,
      required this.myUserId})
      : super(key: key);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "";
  String chatMateFirstName = "";
  String chatMateLastName = "";
  String chatMateUserId = "";

  getThisUserInfo() async {
    chatMateUserId =
        widget.chatRoomId.replaceAll(widget.myUserId, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await getUserInfo(chatMateUserId);
    chatMateFirstName = "${querySnapshot.docs[0]["firstName"]}";
    chatMateLastName = "${querySnapshot.docs[0]["lastName"]}";
    profilePicUrl = "${querySnapshot.docs[0]["image"]}";
    setState(() {});
  }

  Future<QuerySnapshot> getUserInfo(String userId) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isEqualTo: userId)
        .get();
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatMateRoom(
                    chatMateFirstName: chatMateFirstName,
                    chatMateLastName: chatMateLastName,
                    chatMateUid: chatMateUserId)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 0, 8),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  profilePicUrl,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$chatMateFirstName $chatMateLastName',
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'PoppinsRegular',
                      letterSpacing: 1.5,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(widget.lastMessage)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
