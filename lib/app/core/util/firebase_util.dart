import 'dart:io';

import 'package:app_adota_fish/app/data/models/photo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class FirebaseUtil {
  File? imageFilePath, resized;

  static Future<Photo> uploadAquarium(String path) async {
    File file = File(path);

    Photo photo = Photo(filepath: file.path);

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      UploadTask task;

      String ref = 'images/aquarium/img-${DateTime.now().toString()}.jpg';
      task = storage.ref(ref).putFile(file);

      await task;
      String url = await task.snapshot.ref.getDownloadURL();
      photo.filepath = url;
      photo.fileType = "png";
      photo.isUploading = false;
      photo.size = task.snapshot.totalBytes.toString();

      return photo;
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload:${e.code}');
    }
    // ignore: dead_code
    return photo;
  }

  static Future<Photo> uploadPet(String path) async {
    File file = File(path);
    Photo photo = Photo(filepath: file.path);

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      UploadTask task;

      String ref = 'images/pet/img-${DateTime.now().toString()}.jpg';
      task = storage.ref(ref).putFile(file);

      await task;
      String url = await task.snapshot.ref.getDownloadURL();
      photo.filepath = url;
      photo.fileType = "png";
      photo.isUploading = false;
      photo.size = task.snapshot.totalBytes.toString();

      return photo;
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload:${e.code}');
    }
    // ignore: dead_code
    return photo;
  }

  static Future<Photo> uploadPhotoClient(String path) async {
    File file = File(path);
    Photo photo = Photo(filepath: file.path);

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      UploadTask task;

      String ref = 'images/account/img-${DateTime.now().toString()}.jpg';
      task = storage.ref(ref).putFile(file);

      await task;
      String url = await task.snapshot.ref.getDownloadURL();
      photo.filepath = url;
      photo.fileType = "png";
      photo.isUploading = false;
      photo.size = task.snapshot.totalBytes.toString();

      return photo;
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload:${e.code}');
    }
    // ignore: dead_code
    return photo;
  }
}
