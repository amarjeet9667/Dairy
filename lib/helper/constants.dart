import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

const Color white = Colors.white;
const Color black = Colors.black;
const Color green = Colors.green;
const Color grey = Colors.grey;
const Color blue = Color.fromARGB(255, 25, 42, 176);
const Color bgColor = Color.fromARGB(255, 225, 189, 231);
const Color appBarColor = Color.fromARGB(255, 124, 131, 228);

// Firebase
var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;
