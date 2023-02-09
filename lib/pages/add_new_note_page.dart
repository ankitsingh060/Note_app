import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/note.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({Key? key , required this.isUpdate, this.note}) : super(key: key);

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  FocusNode noteFocus = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addNewNote(){
    Note newNote = Note(
      id: const Uuid().v1(),
      userid: 'ankitsingh',
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now()
    );

    Provider.of<NotesProvider>(context,listen: false).addNote(newNote);
    Navigator.pop(context);
  }
  @override
  void initState() {
    super.initState();

    if(widget.isUpdate){
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  void updateNote(){
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    Provider.of<NotesProvider>(context,listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            if(widget.isUpdate){
              updateNote();
            }
            else{
              addNewNote();
            }
              }, icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10
          ),
          child: Column(
            children:  [
              TextField(
                controller: titleController,
                autocorrect: (widget.isUpdate== true) ? false : true,
                autofocus: true,
                onSubmitted: (val){
                  if(val != "") {
                    noteFocus.requestFocus();
                  }
                },
                style: TextStyle(
                  fontSize: 30
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none
                ),
              ),

              Expanded(
                child: TextField(
                  controller: contentController,
                  focusNode: noteFocus,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "notes",
                    border: InputBorder.none
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
