import 'package:flutter/material.dart';
import 'package:training_app/bloc%20controller/api_calling_bloc/api_bloc.dart';
import 'package:training_app/bloc%20controller/api_calling_bloc/bloc_event.dart';
import 'package:training_app/bloc%20controller/api_calling_bloc/bloc_state.dart';
import 'package:training_app/bloc%20controller/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/models/userdata.dart';

class BlocManagementScreen extends StatelessWidget {
  const BlocManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Bloc Management"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: BlocProvider<CounterBloc>(
        lazy: true,
        create: (BuildContext context) => CounterBloc(),
        child: const ShowCounter(),
      ),
    );
  }
}

class APIExampleOfBloc extends StatelessWidget {
  const APIExampleOfBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiBloc apiBloc = ApiBloc();
    apiBloc.add(GetApiList());
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Api Calling With Bloc"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocProvider<ApiBloc>(
            create: (BuildContext context) => apiBloc,
            child: BlocConsumer<ApiBloc, ApiState>(
              listener: (context, state) {
                if (state is ApiError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ApiLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ApiLoaded) {
                  List<UserData> data = state.dataList;
                  return Container(
                    height: 700,
                    alignment: Alignment.center,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white12,
                          child: ListTile(
                            title: Text(
                              data[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "Mail :- ${data[index].email}\nGender :- ${data[index].gender}",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShowCounter extends StatelessWidget {
  const ShowCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Text(
              '$state',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            );
          },
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text("increment"),
              onPressed: () {
                counterBloc.add(Event.increment);
                // context.read<CounterBloc>().increment();
              },
            ),
            ElevatedButton(
              child: const Text("decrement"),
              onPressed: () {
                counterBloc.add(Event.decrement);
                // context.read<CounterBloc>().decrement();
              },
            ),
          ],
        )
      ],
    );
  }
}
