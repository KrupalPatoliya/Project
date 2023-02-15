import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:training_app/redux/counter_redux.dart';

class ReduxManagementScreen extends StatelessWidget {
  const ReduxManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<int> store = Store<int>(CounterRedux.counterRedux.counterReducer, initialState: 0);
    return StoreProvider<int>(
      store: store,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Redux Management"),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StoreConnector<int, String>(
                converter: (store) => store.state.toString(),
                builder: (context, count) => Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: "1",
                    onPressed: () {
                      store.dispatch(Event.increment);
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 50),
                  FloatingActionButton(
                    heroTag: "2",
                    onPressed: () {
                      store.dispatch(Event.decrement);
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
