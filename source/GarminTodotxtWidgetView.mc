using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Lang;
using Toybox.Graphics;

class GarminTodotxtWidgetView extends Ui.View {
  var _todos;
  var _maxCharsPerLine = 20;
  var _rows = 7;

  function initialize(todos) {
    View.initialize();
    _todos = todos;
  }

  // Helper function to word-wrap a string by words, maxLen per line
  function wordWrapByWords(text, maxLen) {
    var words = [];
    var s = text;
    while (s.length() > 0) {
      var chars = s.toCharArray();
      var splitIndex = -1;
      for (var i = 0; i < chars.size(); i++) {
        if (chars[i] == " ".toCharArray()[0]) {
          splitIndex = i;
          break;
        }
      }
      if (splitIndex == -1) {
        words.add(s);
        break;
      } else {
        words.add(s.substring(0, splitIndex));
        s = s.substring(splitIndex + 1, s.length());
      }
    }
    var lines = [];
    var currentLine = "";
    for (var i = 0; i < words.size(); ++i) {
      var word = words[i];
      if (currentLine.length() == 0) {
        currentLine = word;
      } else if (currentLine.length() + 1 + word.length() <= maxLen) {
        currentLine += " " + word;
      } else {
        lines.add(currentLine);
        currentLine = word;
      }
    }
    if (currentLine.length() > 0) {
      lines.add(currentLine);
    }
    return lines;
  }

  function onLayout(dc) {
    setLayout(Rez.Layouts.MainLayout(dc));
    var allLines = [];
    for (var i = 0; i < _todos.size(); ++i) {
      var wrapped = wordWrapByWords("- " + _todos[i], _maxCharsPerLine);
      for (var j = 0; j < wrapped.size(); ++j) {
        allLines.add(wrapped[j]);
      }
    }
    // Set up to max rows defined in layout
    for (var row = 1; row <= _rows; ++row) {
      var text = row - 1 < allLines.size() ? allLines[row - 1] : "";
      View.findDrawableById("row" + row).setText(text);
    }
  }

  function onShow() {}

  function onUpdate(dc) {
    View.onUpdate(dc);
  }

  function onHide() {}
}
