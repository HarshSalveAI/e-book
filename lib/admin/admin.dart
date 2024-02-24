import 'package:e_book/Pages/WelcomePage/WelcomePage.dart';
import 'package:e_book/admin/books.dart';
import 'package:e_book/admin/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  late TabController tbcon;

  @override
  void initState() {
    super.initState();
    tbcon = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Book Admin'),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => WelcomePage()));
                  })
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://img.icons8.com/color/48/monkey-d-luffy.png")),
              title: Text(
                'Welcome Admin ! ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Qwerty Micro")]),
            ),
          ),
          TabBar(
            indicatorColor: Colors.black,
            controller: tbcon,
            tabs: const [
              Tab(
                text: "Books",
              ),
              Tab(
                text: "Users",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tbcon,
              children: [
                Center(child: BooksDetailes()),
                Center(
                  child: UsersDetailes(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
