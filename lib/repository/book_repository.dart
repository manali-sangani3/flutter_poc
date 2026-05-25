import '../model/book_model.dart';
import '../services/book_service.dart';

class BookRepository {
  final BookService service;

  // providing dependencies from outside instead of creating them inside a class.
  BookRepository(this.service);

  List<BookModel> fetchBooks() {
    return service.getBooks();
  }

  void addBook(BookModel book) {
    service.addBook(book);
  }

  void deleteBook(int index) {
    service.removeBook(index);
  }
}
