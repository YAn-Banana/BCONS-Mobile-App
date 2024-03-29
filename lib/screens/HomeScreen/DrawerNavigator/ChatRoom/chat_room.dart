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
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(shrinkWrap: true, children: [chatRoomsList()])),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String? lastMessage;
  final String? chatRoomId;
  final String? myUserId;

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
  String? profilePicUrl;
  String? chatMateFirstName;
  String? chatMateLastName;
  String? chatMateUserId;
  String? status;

  getThisUserInfo() async {
    chatMateUserId =
        widget.chatRoomId!.replaceAll(widget.myUserId!, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await getUserInfo(chatMateUserId!);
    chatMateFirstName = "${querySnapshot.docs[0]["firstName"]}";
    chatMateLastName = "${querySnapshot.docs[0]["lastName"]}";
    profilePicUrl = "${querySnapshot.docs[0]["image"]}";
    status = "${querySnapshot.docs[0]["status"]}";
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatMateRoom(
                        chatMateFirstName: chatMateFirstName!,
                        chatMateLastName: chatMateLastName!,
                        chatMateUid: chatMateUserId!,
                        status: status!,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                status == 'online'
                    ? CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.green[800],
                      )
                    : const CircleAvatar(
                        radius: 10,
                        backgroundColor: Color(0xffd90824),
                      ),
                const SizedBox(
                  width: 10,
                ),
                profilePicUrl == null
                    ? Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/profile.png'),
                                fit: BoxFit.cover)),
                      )
                    : Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(profilePicUrl!),
                                fit: BoxFit.cover)),
                      ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$chatMateFirstName $chatMateLastName',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(widget.lastMessage!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
