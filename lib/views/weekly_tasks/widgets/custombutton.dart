import 'package:flutter/material.dart';

Widget customButton({required String name, required VoidCallback tap}) {
  // String? name;

  return GestureDetector(
    onTap: tap,
    child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Material(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide(color: Colors.blue, width: 1.5),
        ),
        color: Colors.blue.shade900,
        child: Container(
          height: 70,
          width: 500,
          alignment: Alignment.center,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ),
  );
}
