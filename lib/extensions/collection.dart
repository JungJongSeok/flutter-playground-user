class Pair<T, U> {
  T first;
  U second;

  Pair(this.first, this.second);

  void setFirst(T first) {
    this.first = first;
  }

  void setSecond(U second) {
    this.second = second;
  }
}

class Triple<T, U, V> {
  T first;
  U second;
  V third;

  Triple(this.first, this.second, this.third);

  void setFirst(T first) {
    this.first = first;
  }

  void setSecond(U second) {
    this.second = second;
  }

  void setThird(V third) {
    this.third = third;
  }
}

class Quadruple<T, U, V, W> {
  T first;
  U second;
  V third;
  W four;

  Quadruple(this.first, this.second, this.third, this.four);

  void setFirst(T first) {
    this.first = first;
  }

  void setSecond(U second) {
    this.second = second;
  }

  void setThird(V third) {
    this.third = third;
  }

  void setFour(W four) {
    this.four = four;
  }
}
