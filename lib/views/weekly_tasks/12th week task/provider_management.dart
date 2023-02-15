import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/provider/counter_provider.dart';

class ProviderManagementScreen extends StatelessWidget {
  const ProviderManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Provider Management"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(builder: (context, value, child) {
              return Text(
                value.count.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: "1",
                  onPressed: () {
                    Provider.of<CounterProvider>(context,listen: false).increment();
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 50),
                FloatingActionButton(
                  heroTag: "2",
                  onPressed: () {
                    Provider.of<CounterProvider>(context,listen: false).decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
