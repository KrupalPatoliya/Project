import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/api_helpper/lazy_loading_api_helpper.dart';
import 'package:training_app/models/userdata.dart';
import 'package:http/http.dart' as http;

class PullToRefreshPage extends StatefulWidget {
  const PullToRefreshPage({Key? key}) : super(key: key);

  @override
  State<PullToRefreshPage> createState() => _PullToRefreshPageState();
}

class _PullToRefreshPageState extends State<PullToRefreshPage> {
  late int id = 0;
  List<UserData?> data = [];
  List<UserData?> data1 = [];
  bool isLoading = false;
  List users = [];

  Future<void> getMoreData() async {
    data1.clear();
    data1 = (await LazyLoadingApiHelpper.lazyLoadingApiHelpper.fetchingMultipleData(id: id++, result: 20))!;
    setState(() {
      if (data1.isNotEmpty) {
        data.clear();
        data.addAll(data1);
      }
    });
    id = id++;
    print(id);
    print(data.first!.name);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getMoreData();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Pull To Refresh",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            print("refresh");
            getMoreData();
          });
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 700,
                child: (data.isNotEmpty)
                    ? ListView.builder(
                        itemCount: data.length,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.white24,
                            child: ListTile(
                              // isThreeLine: true,
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundColor: Colors.blueAccent.shade100,
                                backgroundImage: CachedNetworkImageProvider(
                                  data[index]!.picture,
                                ),
                              ),
                              title: Text(
                                (data[index]!.name),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                (data[index]!.email),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
