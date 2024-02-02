import 'package:flutter/material.dart';

enum colorText {
  primary(Colors.white),
  second(Colors.black),
  background(Colors.black54),
  rest(Colors.white60),
  button(Colors.red),
  star(Colors.amber);

  const colorText(this.color);
  final Color color;
}

class MusicType {
  final String name;
  final List<String> names;

  const MusicType(this.name, {this.names = const []});
}

const MusicType all = MusicType("all");
const MusicType silent = MusicType("silent",
    names: ["silent1", "silent2", "silent3", "silent4", "silent5"]);
const MusicType energy = MusicType("energy",
    names: ["energy1", "energy2", "energy3", "energy4", "energy5"]);

String UppCaseFirstWord(String word) {
  return word[0].toUpperCase() + word!.substring(1);
}
