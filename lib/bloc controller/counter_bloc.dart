import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

//
// class CounterBloc extends BlocObserver {
//
//   @override
//   void onClose(BlocBase bloc) {
//     // TODO: implement onClose
//     super.onClose(bloc);
//   }
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     // TODO: implement onChange
//     super.onChange(bloc, change);
//   }
//
// }

abstract class Counting extends Equatable {
  const Counting();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Increment extends Counting {}

class Decrement extends Counting {}

enum Event { increment, decrement }

class CounterBloc extends Bloc<Event, int> {
  /// {@macro counter_cubit}
  CounterBloc() : super(0) {
    on((event, emit) {
      if (event == Event.increment) {
        emit(state + 1);
      } else {
        if(state == 0){
        }else {
          emit(state - 1);
        }
      }
    });
  }

  @override
  void onChange(Change<int> change) {
    // TODO: implement onChange
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
  }
}

// class CounterBloc extends Cubit<int> {
//   /// {@macro counter_cubit}
//   CounterBloc() : super(0);
//
//   /// Add 1 to the current state.
//   void increment() {
//     emit(state + 1);
//   }
//
//   /// Subtract 1 from the current state.
//   void decrement() {
//     emit(state - 1);
//   }
// }
