dynamic oddOrEven(int number) {
  // TODO 1

  if (number % 2 == 0) {
    return 'genap';
  } else {
    return 'ganjil';
  }

  // End of TODO 1
}

dynamic createListOneToX(int x) {
  final List<int> list = [];

  // TODO 2
  if (x > 0) {
    for (int i = 1; i <= x; i++) {
      list.add(i);
    }
  }

  // End of TODO 2

  return list;
}

String getStars(int n) {
  var result = '';

  // TODO 3
  for (int i = n; i > 0; i--) {
    for (int j = 0; j < i; j++) {
      result += '*';
    }
    result += '\n';
  }
  // End of TODO 3

  return result;
}
