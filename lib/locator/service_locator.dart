import 'package:get_it/get_it.dart';

import '../repository/book_repository.dart';
import '../services/book_service.dart';

final getIt = GetIt.instance;

void setupLocator() {

  /// Service Singleton
  getIt.registerLazySingleton<BookService>(
        () => BookService(),
  );

  /// Repository Singleton
  getIt.registerLazySingleton<BookRepository>( // Creates object only when first used.
        () => BookRepository(
      getIt<BookService>(),
    ),
  );
}