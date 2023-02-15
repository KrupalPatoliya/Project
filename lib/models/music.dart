import 'dart:io';
import 'dart:typed_data';

class Music {
  int id;
  String name;
  String title;
  File files;

  // Uint8List file;

  Music({required this.name, required this.title, required this.files,required this.id});
}

class Video {
  String name;
  String title;
  File files;
  Uint8List file;

  Video({required this.name, required this.title, required this.files, required this.file});
}


class ImageFile {
  int id;
  String name;
  String title;
  File files;
  Uint8List file;

  ImageFile({required this.name, required this.title, required this.files, required this.file,required this.id});
}
