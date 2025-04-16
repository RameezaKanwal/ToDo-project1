import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> todos = [];
  List<Map<String, dynamic>> filteredTodos = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterTodos);
  }

  void _addTodo() {
    final text = _taskController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        todos.add({'text': text, 'done': false});
        _taskController.clear();
        _filterTodos(); // update filtered list
      });
    }
  }

  void _deleteTodo(int index) {
    setState(() {
      final actualItem = filteredTodos[index];
      todos.remove(actualItem);
      _filterTodos();
    });
  }

  void _toggleDone(int index) {
    setState(() {
      final actualItem = filteredTodos[index];
      final itemIndex = todos.indexOf(actualItem);
      todos[itemIndex]['done'] = !todos[itemIndex]['done'];
      _filterTodos();
    });
  }

  void _filterTodos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredTodos = todos.where((todo) {
        final text = todo['text'].toLowerCase();
        return text.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu, size: 30),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Icon(Icons.person, size: 30),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.deepOrangeAccent,
                          size: 25,
                        ),
                        border: InputBorder.none,
                        hintText: "Search",
                        helperStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Heading
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "My ToDo's",
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),

          // Add Task Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: "Enter a task...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTodo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15),
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),

          // ToDo List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                final item = filteredTodos[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        item['done'] ? Icons.check_circle : Icons.circle_outlined,
                        color: item['done']
                            ? Colors.deepOrangeAccent
                            : Colors.grey,
                      ),
                      onPressed: () => _toggleDone(index),
                    ),
                    title: Text(
                      item['text'],
                      style: TextStyle(
                        fontSize: 18,
                        decoration: item['done']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.deepOrangeAccent),
                      onPressed: () => _deleteTodo(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
