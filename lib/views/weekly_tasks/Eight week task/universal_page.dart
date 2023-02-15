import 'package:flutter/material.dart';

class UniversalPage extends StatefulWidget {
  const UniversalPage({Key? key}) : super(key: key);

  @override
  State<UniversalPage> createState() => _UniversalPageState();
}

class _UniversalPageState extends State<UniversalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Universal App"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("LDPI",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),

              SizedBox(height: 10),
              Image(
                image: AssetImage("assets/appIcons/ldpi.png"),
              ),
              SizedBox(height: 20),
              SizedBox(height: 10),
              Text("MDPI",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
              SizedBox(height: 10),
              Image(
                image: AssetImage("assets/appIcons/mdpi.png"),
              ),
              SizedBox(height: 20),
              Text("HDPI",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
              SizedBox(height: 10),
              Image(
                image: AssetImage("assets/appIcons/hdpi.png"),
              ),
              SizedBox(height: 20),
              Text("XHDPI",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
              SizedBox(height: 10),
              Image(
                image: AssetImage("assets/appIcons/xhdpi.png"),
              ),
              SizedBox(height: 20),
              Text("XXHDPI",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
              SizedBox(height: 10),
              Image(
                image: AssetImage("assets/appIcons/xxhdpi.png"),
              ),
              SizedBox(height: 20),
              Text("XXXHDPI",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
              SizedBox(height: 10),
              Image(
                image: AssetImage("assets/appIcons/xxxhdpi.png"),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
