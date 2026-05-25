import 'package:flutter/material.dart';

import '../locator/service_locator.dart';
import '../model/book_model.dart';
import '../repository/book_repository.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final repository = getIt<BookRepository>();

  final titleController = TextEditingController();

  final authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final books = repository.fetchBooks();

    return Scaffold(
      appBar: AppBar(title: const Text("Library Manager")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: titleController,

              decoration: const InputDecoration(hintText: "Book Title"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: authorController,

              decoration: const InputDecoration(hintText: "Author Name"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                repository.addBook(
                  BookModel(
                    title: titleController.text,

                    author: authorController.text,
                  ),
                );

                titleController.clear();
                authorController.clear();
                setState(() {});
              },

              child: const Text("Add Book"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: books.length,

                itemBuilder: (context, index) {
                  final book = books[index];

                  return ListTile(
                    title: Text(book.title),

                    subtitle: Text(book.author),

                    trailing: IconButton(
                      onPressed: () {
                        repository.deleteBook(index);

                        setState(() {});
                      },

                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
