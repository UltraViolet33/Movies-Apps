import 'package:app/views/screens/profil_screen.dart';
import 'package:app/views/screens/random_movies.dart';
import 'package:app/views/screens/search_screen.dart';
import 'package:app/views/screens/user_lists_screen.dart';
import 'package:flutter/material.dart';

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// API ENDPOINTS
const apiEndpoint = "http://192.168.1.10:5000";

const pages = [
  UserListsScreen(),
  SearchScreen(),
  RandomMovies(),
  ProfilScreen(),
];
