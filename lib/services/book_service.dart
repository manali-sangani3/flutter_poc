import '../model/book_model.dart';

class BookService {

  final List<BookModel> _books = [];

  List<BookModel> getBooks() {
    return _books;
  }

  void addBook(BookModel book) {
    _books.add(book);
  }

  void removeBook(int index) {
    _books.removeAt(index);
  }
}