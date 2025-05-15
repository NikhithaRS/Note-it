import 'package:flutter/material.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final List<String> _notes = [];
  bool _isDarkMode = false;
  final TextEditingController _inp = TextEditingController();
  int? _editingIndex;

  void _addNote(String content) {
    setState(() {
      _notes.add(content);
      _inp.clear();
    });
  }

  void _editNote(updatedContent, index) {
    setState(() {
      _notes[index] = updatedContent;
      _inp.clear();
    });
  }

  void _delNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("📝 Note it"),
          //centerTitle: true,
          elevation: 10,
          actions: [
            Icon(Icons.light_mode),
            Switch(
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            Icon(Icons.dark_mode),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(_notes[index]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _inp.text = _notes[index];
                                _editingIndex = index;
                              },
                              icon: Icon(Icons.edit, color: Colors.blue),
                            ),
                            IconButton(
                              onPressed: () {
                                _delNote(index);
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _inp,
                decoration: InputDecoration(
                  hintText: "Enter your note",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  prefixIcon: Icon(Icons.note),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _addNote(_inp.text);
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add Note"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _editNote(_inp.text, _editingIndex);
                      },
                      icon: Icon(Icons.save),
                      label: Text("Save Edit"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}