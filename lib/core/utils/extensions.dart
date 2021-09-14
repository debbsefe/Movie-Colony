import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double height(double value) => mediaQuery.size.height * value;
  double width(double value) => mediaQuery.size.width * value;
}

extension StringExtensions on String {
  ///extension method to get baseurl path
  String get baseurl => 'https://api.themoviedb.org/3/$this';

  ///extension method capitalize the first letter of a sentence
  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get imageUrl => 'https://image.tmdb.org/t/p/w500/$this';
}

extension PostFrameCallback on VoidCallback {
  void withPostFrameCallback() =>
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        this();
      });
}
