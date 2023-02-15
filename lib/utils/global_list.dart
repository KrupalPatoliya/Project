import 'package:flutter/material.dart';
import 'package:training_app/models/draggale.dart';
import 'package:training_app/models/gallery_example_item.dart';
import 'package:training_app/models/product.dart';

List<Product> products = [
  Product(
    id: 1,
    name: "Salad",
    price: 20.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNc9bcaXx6kdlA-0ZByLpRz8pCYeRAFuSUfw&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 20.0,
  ),
  Product(
    id: 2,
    name: "Monsoon Salad",
    price: 15.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-d-uvgeRapxtYu7RrIDc9eGRqM7QxzyAodg&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 15.0,
  ),
  Product(
    id: 3,
    name: "Royal Salad",
    price: 25.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUf6zlgH4HnDEpY4RubUXP4EPE7VFpVYyh1Q&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 25.0,
  ),
  Product(
    id: 4,
    name: "Fruits Salad",
    price: 10.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIPvzkN4olXhmv3PBh2ZXEPRv-AQo_kv_0Kw&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 10.0,
  ),
  Product(
    id: 5,
    name: "Loyal Salad",
    price: 28.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR18TP0xdZoP6hhi_rLqus0h5vt4kHFWNuoXQ&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 28.0,
  ),
  Product(
    id: 6,
    name: "Basic Salad",
    price: 10.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJnJXcQGcDo_5Y1w2FPlnDZuxUb8r8e6nYqg&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 10.0,
  ),
  Product(
    id: 7,
    name: "All Fruits",
    price: 23.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyhLO6SIIt7fO1QULDmMWopQDgG_X6s5LXaQ&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 23.0,
  ),
  Product(
    id: 8,
    name: "Mi Fruits",
    price: 29.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiHmw_nmJ-HYQatJ02btnLcZEmR3LUv419Cg&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 29.0,
  ),
  Product(
    id: 9,
    name: "Unique Fruits",
    price: 40.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAl6jWJ6zx69xl18tfF-jl3anbFzL011bwqQ&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 40.0,
  ),
  Product(
    id: 10,
    name: "All Grocery",
    price: 100.0,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhxLABjqmhhydx-yRaieijXbm6kzxc7yQiBg&usqp=CAU",
    quantity: 1,
    isLike: false,
    price2: 100.0,
  ),
];

List<GalleryExampleItem> items = [
  GalleryExampleItem(id: "tab1", resource: "assets/author.jpg"),
  GalleryExampleItem(id: "tab2", resource: "assets/bird.jpg"),
  GalleryExampleItem(id: "tab3", resource: "assets/download.jpeg"),
  GalleryExampleItem(id: "tab4", resource: "assets/images.jpeg"),
  GalleryExampleItem(id: "tab5", resource: "assets/images1.jpeg"),
  GalleryExampleItem(id: "tab6", resource: "assets/images2.jpeg"),
  GalleryExampleItem(id: "tab7", resource: "assets/images3.jpeg"),
  GalleryExampleItem(id: "tab8", resource: "assets/images4.jpeg"),
];

List<FruitItem> fruitsName = [
  FruitItem(
    color: Colors.deepPurple,
    name: "Grapes",
    id: 4,
    image: "assets/grape.png",
  ),
  FruitItem(
    color: Colors.red,
    name: "Apple",
    id: 2,
    image: "assets/apple.png",
  ),
  FruitItem(
    color: Colors.redAccent,
    name: "Strawberry",
    id: 6,
    image: "assets/strawberry.png",
  ),
  FruitItem(
    color: Colors.amber,
    name: "Mango",
    id: 5,
    image: "assets/mango.png",
  ),
];

List<FruitImage> fruitsImages = [
  FruitImage(
    color: Colors.red,
    name: "Apple",
    image: "assets/apple.png",
  ),
  FruitImage(
    color: Colors.deepPurple,
    name: "Grapes",
    image: "assets/grape.png",
  ),
  FruitImage(
    color: Colors.amber,
    name: "Mango",
    image: "assets/mango.png",
  ),
  FruitImage(
    color: Colors.redAccent,
    name: "Strawberry",
    image: "assets/strawberry.png",
  ),
];
