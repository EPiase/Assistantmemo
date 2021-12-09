import 'package:flutter/material.dart';
import 'package:assistantmemo/services/models.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  const NoteItem({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: note.audio_filename,
      child: Card(
        color: Colors.blue,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => NoteScreen(note: note),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: Center(
                    child: Icon(Icons.sticky_note_2,
                        color: Colors.black,
                        size: MediaQuery.of(context).size.width * .5),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    note.text_transcript,
                    style: const TextStyle(
                      height: 1.5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  ),
                ),
              ),
              // Flexible(child: NoteProgress(note: note)),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteScreen extends StatelessWidget {
  final Note note;

  const NoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: ListView(children: [
        Hero(
            tag: note.classification,
            child: Icon(Icons.sticky_note_2, size: 75)),
        Text(
          note.text_transcript,
          style: const TextStyle(
              height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
