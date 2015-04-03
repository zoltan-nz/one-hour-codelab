// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math' show Random;

ButtonElement genButton;

void main() {
  querySelector('#inputName').onInput.listen(updateBadge);
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
}

void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;

  setBadgeName(new PirateName(firstName: inputName));

  if (inputName.trim().isEmpty) {
    genButton ..disabled = false
              ..text  = 'Aye! Gimme a Name';
  } else {
    genButton ..disabled = true
              ..text = 'Arrr! Write yer name!';
  }
}

void setBadgeName(PirateName newName) {
  querySelector('#badgeName').text = newName.pirateName;
}

void generateBadge(Event e) {
  setBadgeName(new PirateName());
}

class PirateName {
  static final Random indexGen = new Random();

  String _firstName;
  String _appellation;

  static final List names = [
    'Anne', 'Mary', 'Jack', 'Morgan'
  ];

  static final List appellations = [
    'Jackal', 'King', 'Red', 'Stalwart'
  ];

  PirateName({String firstName, String appellation}) {

    if (firstName == null) {
      _firstName = names[indexGen.nextInt(names.length)];
    } else {
      _firstName = firstName;
    }

    if (appellation == null) {
      _appellation = appellations[indexGen.nextInt(appellations.length)];
    } else {
      _appellation = appellation;
    }
  }

  String get pirateName =>
    _firstName.isEmpty ? '' : '$_firstName the $_appellation';

  String toString() => pirateName;
}