import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditBookpg extends StatefulWidget {
  final String docId;
  final String initialTitle;
  final String initialdescription;
  final String initialAuthor;
  final String initialrating;
  final int initialprice;
  final int initialpages;
  final String initialbookdesc;
  final String initiallanguage;
  final String initialcategory;

  const EditBookpg({
    required this.docId,
    required this.initialTitle,
    required this.initialAuthor,
    required this.initialrating,
    required this.initialdescription,
    required this.initialcategory,
    required this.initialbookdesc,
    required this.initiallanguage,
    required this.initialpages,
    required this.initialprice,

    // wo books wale class ie wo btn click pe jo keys&values hai wo construtor me define kar na jese wo value controller pe attach lar sakte hai
  });

  @override
  _EditBookpgState createState() => _EditBookpgState();
}

class _EditBookpgState extends State<EditBookpg> {
  late TextEditingController _titleController;
  late TextEditingController _ratingController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _languageController;
  late TextEditingController _bookdescController;
  late TextEditingController _pagesController;
  late TextEditingController _priceController;
  // baki fields ke controller idhar define kar na

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _authorController = TextEditingController(text: widget.initialAuthor);
    _descriptionController =
        TextEditingController(text: widget.initialdescription);
    _ratingController = TextEditingController(text: widget.initialrating);
    _priceController =
        TextEditingController(text: widget.initialprice.toString());
    _categoryController = TextEditingController(text: widget.initialcategory);
    _pagesController = TextEditingController(text: widget.initialpages.toString());
    _languageController = TextEditingController(text: widget.initiallanguage);
    _bookdescController = TextEditingController(text: widget.initialbookdesc);

    // at initial state ie jab app load ho ga tab perivous value controller pe attach ne ke liye wo value set kar na
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _languageController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _ratingController.dispose();
    _pagesController.dispose();
    _bookdescController.dispose();

    // baki sare controller according to ur need idhar add kar for destory kar ne ke liya
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // baki entities ko isme add karna as a controller
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _languageController,
              decoration: InputDecoration(labelText: 'language'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Author Description'),
            ),
            TextField(
              controller: _bookdescController,
              decoration: InputDecoration(labelText: 'Book description'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _ratingController,
              decoration: InputDecoration(labelText: 'Ratings'),
            ),
            TextField(
              controller: _pagesController,
              decoration: InputDecoration(labelText: 'Pages'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Books')
                    .doc(widget.docId)
                    .update({
                  // baki sare pervious fields ke value ko textfield me define karna (key:newvalues)
                  'title': _titleController.text,
                  'author': _authorController.text,
                  'aboutAuthor': _descriptionController.text,
                  'language': _languageController.text,
                  'category': _categoryController.text,
                  'description': _bookdescController.text,
                  'price': _priceController.text,
                  'rating': _ratingController.text,
                  'pages': _pagesController.text,
                }).then((_) {
                  Navigator.of(context).pop();
                });
                SnackBar(
                  content: Text('Book updated successfullly'),
                  duration: Duration(seconds: 2),
                );
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
