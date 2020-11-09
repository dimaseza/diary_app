import 'dart:io';

import 'package:flutter/foundation.dart';

class Diary {
  final String id;
  final String title;
  final String description;
  final File image;
  final String date;

  Diary({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.date,
  });
}
