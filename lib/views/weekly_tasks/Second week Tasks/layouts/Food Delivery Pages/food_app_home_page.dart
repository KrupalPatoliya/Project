import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/global_list.dart';

class FoodAppHomePage extends StatefulWidget {
  const FoodAppHomePage({Key? key}) : super(key: key);

  @override
  State<FoodAppHomePage> createState() => _FoodAppHomePageState();
}

class _FoodAppHomePageState extends State<FoodAppHomePage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  Map<String, bool> map = {
    "Teriyaki": true,
    "Yakiniku": false,
  };
  Map<String, bool> map1 = {
    "Omelet": true,
    "Sausage": false,
    "Cheese": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_add_outlined, color: Colors.black),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xff2b614e),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        currentIndex: _selectedIndex,
        onTap: (val) {
          setState(() {
            _selectedIndex = val;
            pageController.animateToPage(val, duration: const Duration(microseconds: 100), curve: Curves.ease);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book_fill),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart_fill),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_alt),
            label: 'Profile',
          ),
        ],
      ),
      body: PageView(
        onPageChanged: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
        controller: pageController,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search your Food",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade700),
                      ),
                      labelText: "Search",
                      labelStyle: TextStyle(
                        color: Colors.green.shade500,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.green.shade300,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.green.shade700,
                      ),
                      focusColor: Colors.green.shade700,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xff4b7b6a),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: const [
                                  Text("Delivery To Home", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                              const Text(
                                "Utama Street no.14 ,Rumbai",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 28,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text("2.4 Km",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff2b614e),
                                    )),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Top Of Week",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 13),
                        SizedBox(
                          height: 260,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                splashColor: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  showModalBottomSheet(
                                    barrierColor: Colors.grey.shade400,
                                    isScrollControlled: true,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(right: Radius.circular(30), left: Radius.circular(30))),
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) => Container(
                                          padding: const EdgeInsets.only(bottom: 30, right: 15, left: 15),
                                          height: 700,
                                          decoration: const BoxDecoration(),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 600,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                                        height: 200,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            image: DecorationImage(image: NetworkImage(products[index].image), fit: BoxFit.cover)),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            products[index].name,
                                                            style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                                          ),
                                                          const Spacer(),
                                                          IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                if (products[index].isLike) {
                                                                  products[index].isLike = false;
                                                                } else {
                                                                  products[index].isLike = true;
                                                                }
                                                              });
                                                            },
                                                            icon: (products[index].isLike)
                                                                ? const Icon(
                                                                    Icons.favorite,
                                                                    color: Colors.pink,
                                                                  )
                                                                : const Icon(
                                                                    Icons.favorite_border,
                                                                    color: Colors.pink,
                                                                  ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  products[index].quantity++;
                                                                  products[index].price2 = products[index].price2 + products[index].price;
                                                                });
                                                              },
                                                              icon: const Icon(Icons.add_circle),
                                                              color: const Color(0xff4b7b6a)),
                                                          Text(products[index].quantity.toString()),
                                                          IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                if (products[index].quantity == 1) {
                                                                } else {
                                                                  products[index].quantity--;
                                                                  products[index].price2 = products[index].price2 - products[index].price;
                                                                }
                                                              });
                                                            },
                                                            icon: const Icon(Icons.remove_circle),
                                                            color: Colors.grey,
                                                          ),
                                                          const SizedBox(width: 20),
                                                          Text(
                                                            "\$ ${products[index].price2}",
                                                            style: const TextStyle(
                                                              color: Color(0xff4b7b6a),
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        height: 3,
                                                        color: Colors.green.shade800,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const Text(
                                                        "Sauce",
                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Divider(
                                                        height: 3,
                                                        color: Colors.green.shade800,
                                                      ),
                                                      SizedBox(
                                                        height: 110,
                                                        child: ListView(
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          children: map.keys
                                                              .map(
                                                                (key) => CheckboxListTile(
                                                                  value: map[key],
                                                                  onChanged: (value) => setState(() => map[key] = value!),
                                                                  title: Text(
                                                                    key,
                                                                    style: const TextStyle(
                                                                        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                                                  ),
                                                                  side: BorderSide(color: Colors.green.shade800, width: 2),
                                                                  activeColor: Colors.green.shade800,
                                                                ),
                                                              )
                                                              .toList(),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 3,
                                                        color: Colors.green.shade800,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const Text(
                                                        "Add a Topping ?",
                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Divider(
                                                        height: 3,
                                                        color: Colors.green.shade800,
                                                      ),
                                                      ListView(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        children: map1.keys
                                                            .map(
                                                              (key) => CheckboxListTile(
                                                                value: map1[key],
                                                                onChanged: (value) => setState(() => map1[key] = value!),
                                                                title: Text(
                                                                  key,
                                                                  style:
                                                                      const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                                                ),
                                                                side: BorderSide(color: Colors.green.shade800, width: 2),
                                                                checkColor: Colors.white,
                                                                activeColor: Colors.green.shade800,
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 60,
                                                  decoration: BoxDecoration(color: const Color(0xff2b614e), borderRadius: BorderRadius.circular(10)),
                                                  width: 400,
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    "Add To Cart",
                                                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 120,
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 120,
                                        height: 170,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade200,
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(image: NetworkImage(products[index].image), fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        products[index].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "\$ ${products[index].price}",
                                        style: const TextStyle(fontSize: 16, color: Color(0xff2b614e), fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text("Menu"),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text("Cart"),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text("Profile"),
          ),
        ],
      ),
    );
  }
}
