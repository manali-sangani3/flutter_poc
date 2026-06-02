// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExpenseStore on _ExpenseStore, Store {
  Computed<double>? _$totalExpenseComputed;

  @override
  double get totalExpense => (_$totalExpenseComputed ??= Computed<double>(
    () => super.totalExpense,
    name: '_ExpenseStore.totalExpense',
  )).value;
  Computed<List<ExpenseModel>>? _$filteredExpensesComputed;

  @override
  List<ExpenseModel> get filteredExpenses =>
      (_$filteredExpensesComputed ??= Computed<List<ExpenseModel>>(
        () => super.filteredExpenses,
        name: '_ExpenseStore.filteredExpenses',
      )).value;

  late final _$expensesAtom = Atom(
    name: '_ExpenseStore.expenses',
    context: context,
  );

  @override
  ObservableList<ExpenseModel> get expenses {
    _$expensesAtom.reportRead();
    return super.expenses;
  }

  @override
  set expenses(ObservableList<ExpenseModel> value) {
    _$expensesAtom.reportWrite(value, super.expenses, () {
      super.expenses = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_ExpenseStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$selectedCategoryAtom = Atom(
    name: '_ExpenseStore.selectedCategory',
    context: context,
  );

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$addExpenseAsyncAction = AsyncAction(
    '_ExpenseStore.addExpense',
    context: context,
  );

  @override
  Future<void> addExpense(ExpenseModel expense) {
    return _$addExpenseAsyncAction.run(() => super.addExpense(expense));
  }

  late final _$_ExpenseStoreActionController = ActionController(
    name: '_ExpenseStore',
    context: context,
  );

  @override
  void removeExpense(int index) {
    final _$actionInfo = _$_ExpenseStoreActionController.startAction(
      name: '_ExpenseStore.removeExpense',
    );
    try {
      return super.removeExpense(index);
    } finally {
      _$_ExpenseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCategory(String value) {
    final _$actionInfo = _$_ExpenseStoreActionController.startAction(
      name: '_ExpenseStore.changeCategory',
    );
    try {
      return super.changeCategory(value);
    } finally {
      _$_ExpenseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
expenses: ${expenses},
isLoading: ${isLoading},
selectedCategory: ${selectedCategory},
totalExpense: ${totalExpense},
filteredExpenses: ${filteredExpenses}
    ''';
  }
}
