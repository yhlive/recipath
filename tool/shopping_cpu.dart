import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:recipath/widgets/generic/search_text.dart';

const _names = ['Tomatoes', 'Rice', 'Lemons', 'Olive oil'];
const _quick = ['Paper towels', 'Sparkling water'];
const _queries = ['TOMA', 'rice', 'LEMon', 'oil', 'water', 'does not exist'];

int _scanShoppingSearch(List<String> index, int rounds) {
  var matches = 0;
  for (var round = 0; round < rounds; round++) {
    for (final rawQuery in _queries) {
      final query = prepareSearchQuery(rawQuery);
      for (final key in index) {
        if (matchesSearchText(key, query)) matches++;
      }
    }
  }
  return matches;
}

Future<void> main(List<String> args) async {
  final index = [
    for (var i = 0; i < 240; i++)
      indexSearchText('1x ${_names[i % 4]} $i (1 pc)'),
    for (var i = 0; i < 60; i++) indexSearchText('${_quick[i % 2]} $i'),
  ];

  if (args.contains('--once')) {
    final watch = Stopwatch()..start();
    final matches = _scanShoppingSearch(index, 500);
    stdout.writeln(
      'rows=${index.length} matches=$matches elapsed_us=${watch.elapsedMicroseconds}',
    );
    return;
  }

  stdout.writeln(
    'Shopping CPU workload running. Record approximately 8 seconds in DevTools; press Ctrl+C when finished.',
  );
  final finish = DateTime.now().add(const Duration(minutes: 3));
  var pulse = 0;
  while (DateTime.now().isBefore(finish)) {
    final count = Timeline.timeSync(
      'shopping.search.burst',
      () => _scanShoppingSearch(index, 200),
    );
    if (++pulse % 20 == 0) {
      stdout.writeln('rows=${index.length} matches=$count');
    }
    await Future<void>.delayed(const Duration(milliseconds: 120));
  }
}
