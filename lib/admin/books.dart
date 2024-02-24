import 'package:e_book/admin/updatebook.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BooksDetailes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Books'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Books').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No books found'),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title'] ?? ''),
                subtitle: Text(data['author'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // sending user to with book ka id to the update widg:
                        print('Editing book: ${doc.id}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditBookpg(
                              // wo sare fields ke currentvalues ko  defined construtor(constructor of EditBookPopup) ko pass karna according to our data
                              docId: doc.id,
                              initialTitle: data['title'] ?? '',
                              initialAuthor: data['author'] ?? '',
                              initialcategory: data['category'] ?? '',
                              initiallanguage: data['language'] ?? '',
                              initialrating: data['rating'] ?? '',
                              initialdescription: data['aboutAuthor'] ?? '',
                              initialbookdesc: data['description'] ?? '',
                              initialpages: data['pages'] ?? '',
                              initialprice: data['price'] ?? '',

                              //....define here
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('Books')
                            .doc(doc.id)
                            .delete();
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
