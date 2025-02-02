import 'dart:io';

void main() {
  Solution obj = Solution();
  obj.analyzeFile();
  obj.calculateLineWithHighestFrequency();
  obj.printHighestWordFrequencyAcrossLines();
}

class Solution {
  List<String> lines = [];
  Map<int, List<String>> highestFreqWordsPerLine = {};
  Map<int, int> highestFreqCountPerLine = {};

  void analyzeFile() {
    File file = File('file.txt');

    if (!file.existsSync()) {
      print("Error: file.txt not found.");
      return;
    }

    lines = file.readAsLinesSync();

    for (int i = 0; i < lines.length; i++) {
      Map<String, int> wordCount = {};
      List<String> words = lines[i]
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '')
          .split(RegExp(r'\s+'))
          .where((word) => word.isNotEmpty)
          .toList();

      for (var word in words) {
        wordCount[word] = (wordCount[word] ?? 0) + 1;
      }

      if (wordCount.isNotEmpty) {
        int maxFreq = wordCount.values.reduce((a, b) => a > b ? a : b);
        List<String> mostFrequentWords = wordCount.entries
            .where((e) => e.value == maxFreq)
            .map((e) => e.key)
            .toList();

        highestFreqWordsPerLine[i + 1] = mostFrequentWords;
        highestFreqCountPerLine[i + 1] = maxFreq;
      }
    }
  }

  void calculateLineWithHighestFrequency() {
    if (highestFreqCountPerLine.isEmpty) return;

    int maxFrequency =
        highestFreqCountPerLine.values.reduce((a, b) => a > b ? a : b);

    List<int> linesWithMaxFrequency = highestFreqCountPerLine.entries
        .where((e) => e.value == maxFrequency)
        .map((e) => e.key)
        .toList();

    print("\nLines with the highest overall word frequency ($maxFrequency):");
    for (var lineNum in linesWithMaxFrequency) {
      print('Line $lineNum: ${highestFreqWordsPerLine[lineNum]}');
    }
  }

  void printHighestWordFrequencyAcrossLines() {
    print("\nThe following words have the highest word frequency per line:");
    highestFreqWordsPerLine.forEach((line, words) {
      print('$words (appears in line $line)');
    });
  }
}
