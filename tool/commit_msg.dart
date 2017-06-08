import 'dart:io';

main(List<String> arguments) {
  final messageFile = new File(arguments[0]);
  final message = messageFile.readAsStringSync();
  final words = message.split(' ').length;

  if (words < 2) {
    print('> Your commit message should consist of at least 2 words!');
    exitCode = 1;
  }
}
