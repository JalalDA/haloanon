import 'package:duapuluhnolnol/components/card_post.dart';
import 'package:duapuluhnolnol/screens/drawer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSearch = false;
  void logout(){
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: showSearch == true
            ? const TextField(
                decoration: InputDecoration(hintText: "Search . . ."),
                autofocus: true,
              )
            : const Text(
                "Timeline",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
                // onTap: () {
                //   setState(() {
                //     showSearch = !showSearch;
                //   });
                // },
                // child: const Icon(
                //   Icons.search_sharp,
                //   size: 30,
                // )),
                onTap: logout,
                child: const Icon(
                  Icons.logout,
                  size: 30,
                )),
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return const CardPost(
              image: "", username: "", post: "", time: "time");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        autofocus: true,
                        ),
                    )
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
