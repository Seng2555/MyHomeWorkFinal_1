import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_homework1/models/people_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PeopleService {
  String tbPeople = 'tbPeople';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createPeople(PeopleModel peopleModel) async {
    try {
      firestore.collection(tbPeople).add(peopleModel.toMap());
    } catch (e) {
      debugPrint('Error create people => $e');
    }
  }

  Stream<List<PeopleModel>> getPeople() {
    return firestore
        .collection(tbPeople)
        .orderBy('name', descending: false)
        .snapshots()
        .map((event) {
      List<PeopleModel> list = [];
      for (var element in event.docs) {
        list.add(PeopleModel.fromDocumentSnapshot(element));
      }
      return list;
    });
  }

  Future<void> updatePeople(PeopleModel people) async {
    try {
      firestore.collection(tbPeople).doc(people.id).update(people.toMap());
    } catch (e) {
      debugPrint('Error update people => $e');
    }
  }

  Future<void> deletePeople(String id) async {
    try {
      firestore.collection(tbPeople).doc(id).delete();
    } catch (e) {
      debugPrint('Error delete people => $e');
    }
  }

  uploadPhoto(File? image) async {
    if (image == null) {
      return;
    } else {
      await firebase_storage.FirebaseStorage.instance
          .ref('upload/${image.path.split("/").last}')
          .putFile(image);
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('upload/${image.path.split("/").last}')
          .getDownloadURL();

      debugPrint("URL : $downloadURL");
      return downloadURL;
    }
  }
}
