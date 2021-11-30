import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7ecf0),
      appBar: AppBar(
        backgroundColor: Color(0xff4a7fc1),
        title: Text('Notes'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.share,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.delete,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text(
            'Converting speech to text here!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
