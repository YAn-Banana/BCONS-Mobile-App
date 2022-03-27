import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/ChatRoom/chat_mate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  TextEditingController searcheditingcontroller = TextEditingController();
  QuerySnapshot? searchSnapshot;
  Stream<QuerySnapshot>? userStream;
  bool isSearching = false;
  Future<Stream<QuerySnapshot>> getUserByUserName(String userName) async {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('municipality', isEqualTo: userName)
        .snapshots();
  }

  onSearchButtonClick() async {
    isSearching = true;
    userStream = await getUserByUserName(searcheditingcontroller.text);
    setState(() {});
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Widget searhListUserTile(String imageUrl, String lastName, String firstName,
      String midName, String email, String uid) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames('${loggedInUser.uid}', uid);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": ['${loggedInUser.uid}', uid]
        };
        createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatMateRoom(
                    chatMateFirstName: firstName,
                    chatMateLastName: lastName,
                    chatMateUid: uid)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              midName.isNotEmpty
                  ? Text(
                      '$firstName $midName. $lastName ',
                      style: const TextStyle(
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          color: Colors.black,
                          fontSize: 12.0),
                    )
                  : Text(
                      '$firstName $lastName ',
                      style: const TextStyle(
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          color: Colors.black,
                          fontSize: 12.0),
                    ),
              Text(
                email,
                style: const TextStyle(
                    fontFamily: 'PoppinsRegular',
                    letterSpacing: 1.5,
                    color: Colors.black,
                    fontSize: 12.0),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget searchList() {
    return StreamBuilder(
        stream: userStream,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          return snapshots.hasData
              ? ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshots.data!.docs[index];
                    return searhListUserTile(
                        ds['image'],
                        ds['lastName'],
                        ds['firstName'],
                        ds['middleInitial'],
                        ds['email'],
                        ds['uid']);
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget chatRoomsList() {
    return Container();
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
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Screen',
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
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                color: const Color(0xffd90824),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                        controller: searcheditingcontroller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintText: 'Search Users by their municipality..',
                            hintStyle: TextStyle(
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontSize: 12.0),
                            border: InputBorder.none)),
                  ),
                  InkWell(
                    onTap: () {
                      onSearchButtonClick();
                    },
                    child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          backgroundColor: Color(0xffcc021d),
                          radius: 50,
                          child: Icon(
                            (Icons.search),
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                  )
                ]),
              ),
              isSearching ? searchList() : chatRoomsList()
            ],
          )),
    );
  }
}
