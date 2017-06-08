import 'dart:io';
import 'package:grinder/grinder.dart';

main(List<String> arguments) {
  if (DartFmt.dryRun('.')) {
    print(
        'Dart files must be formatted with dartfmt. Please run: dartfmt -w .');
    exitCode = 1;
  }
}
