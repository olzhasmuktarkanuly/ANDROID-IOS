void main() {
  String userName = "Olzhas";
  double balance = 1500.0;

  checkBalance(name: userName, balance: balance);

  balance = deposit(currentBalance: balance, amount: 500.0);

  balance = withdraw(
      name: userName,
      currentBalance: balance,
      amount: 300.0,
      pinCode: 1234
  );

  balance = withdraw(
      name: userName,
      currentBalance: balance,
      amount: 100.0
  );

  balance = withdraw(
      name: userName,
      currentBalance: balance,
      amount: 5000.0,
      pinCode: 1234
  );
}

void checkBalance({required String name, required double balance})=>
    print("Client$name Current balance\$$balance");

double deposit({required double currentBalance, double? amount}) {
  double actualAmount = amount ?? 0.0;
  double newBalance = currentBalance + actualAmount;
  print("Deposited\$$actualAmount New balance\$$newBalance");
  return newBalance;
}

double withdraw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}) {
  int actualPin = pinCode ?? 0000;

  if (actualPin != 1234) {
    print("ErrorIncorrect PIN");
    return currentBalance;
  }

  double actualAmount = amount ?? 0.0;

  if (actualAmount > currentBalance) {
    print("Error:Insufficient funds.");
    return currentBalance;
  }

  double newBalance = currentBalance - actualAmount;
  print("Success $name withdrew \$$actualAmount. Remaining balance: \$$newBalance");
  return newBalance;
}

