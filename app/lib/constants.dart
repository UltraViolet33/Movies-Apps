import 'package:app/views/screens/random_movies.dart';
import 'package:flutter/material.dart';
// import 'package:tiktok_clone/controllers/auth_controller.dart';

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// CONTROLLER
// var authController = AuthController.instance;

// API ENDPOINTS
const apiEndpoint = "http://192.168.1.10:5000";

const pages = [
  Text("Home screen"),
  RandomMovies(),
  Text("Search screen"),
  Text("Watch List screen"),
  Text("Random movies screen"),
];
