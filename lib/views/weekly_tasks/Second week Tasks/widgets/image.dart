import 'package:flutter/material.dart';

class ImageShower extends StatefulWidget {
  const ImageShower({Key? key}) : super(key: key);

  @override
  State<ImageShower> createState() => _ImageShowerState();
}

class _ImageShowerState extends State<ImageShower> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Image"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Network Image",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 400,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border(
                    top: BorderSide(color: Colors.blue.shade900, width: 3),
                    right: BorderSide(color: Colors.blue.shade900, width: 3),
                    bottom: BorderSide(color: Colors.blue.shade900, width: 3),
                    left: BorderSide(color: Colors.blue.shade900, width: 3),
                  ),
                ),
                child: const Image(
                  image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2013/04/04/12/34/mountains-100367__340.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Assets Image",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 400,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border(
                    top: BorderSide(color: Colors.blue.shade900, width: 3),
                    right: BorderSide(color: Colors.blue.shade900, width: 3),
                    bottom: BorderSide(color: Colors.blue.shade900, width: 3),
                    left: BorderSide(color: Colors.blue.shade900, width: 3),
                  ),
                ),
                child: const Image(
                  image: AssetImage('assets/bird.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
