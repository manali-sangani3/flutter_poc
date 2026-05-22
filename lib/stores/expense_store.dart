import 'package:mobx/mobx.dart';

import '../model/expense_model.dart';

part 'expense_store.g.dart';

class ExpenseStore = _ExpenseStore with _$ExpenseStore;

abstract class _ExpenseStore with Store {
  @observable // Marks variables as reactive state.

  //ObservableList: Reactive list that automatically updates UI.
  ObservableList<ExpenseModel> expenses = ObservableList<ExpenseModel>();

  @observable
  bool isLoading = false;

  @observable
  String selectedCategory = "All";

  @computed
  double get totalExpense {
    return expenses.fold(0, (sum, item) => sum + item.amount);
  }

  @computed // Derived/calculated state from observables.
  List<ExpenseModel> get filteredExpenses {
    if (selectedCategory == "All") {
      return expenses;
    }

    return expenses.where((e) {
      return e.category == selectedCategory;
    }).toList();
  }

  @action // Used to modify observable state safely.
  Future<void> addExpense(ExpenseModel expense) async {
    isLoading = true;

    await Future.delayed(const Duration(seconds: 1));

    expenses.add(expense);

    isLoading = false;
  }

  @action
  void removeExpense(int index) {
    expenses.removeAt(index);
  }

  @action
  void changeCategory(String value) {
    selectedCategory = value;
  }
}
