enum Event { increment, decrement }

class CounterRedux {
  CounterRedux._();

  static final CounterRedux counterRedux = CounterRedux._();

  int counterReducer(int count, dynamic event) {
    if (event == Event.increment) {
      return (count + 1);
    } else {
      if(count == 0){
        return 0;
      }
      else {
        return (count - 1);
      }
    }
  }
}
