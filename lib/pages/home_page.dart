import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import 'add_new_note_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key, }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Note application"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: (notesProvider.notes.length >0) ?GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
            ),
            itemCount: notesProvider.notes.length,
            itemBuilder: (context, index){

              Note currentNote = notesProvider.notes[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => AddNewNotePage(isUpdate: true, note: currentNote,))
                  );
                },
                onLongPress: (){
                  notesProvider.deleteNote(currentNote);
                },

                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2
                    )
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentNote.title!, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey.shade600),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      Text(currentNote.content!, style: TextStyle(fontSize: 15,color: Colors.blueGrey),maxLines: 5, overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),
              );
            })
            : Center(
          child: Text("No note Yet"),
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => AddNewNotePage(isUpdate:false)
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
