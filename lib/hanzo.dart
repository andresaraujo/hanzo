library hanzo;

import 'dart:async';
import 'dart:io';
import 'package:command_wrapper/command_wrapper.dart';

Future<Null> install(List<String> hooksToAdd) async {
  if (hooksToAdd[0] == 'all') {
    return hooks.forEach(createHook);
  }
  return hooks.where((h) => hooksToAdd.contains(h)).forEach(createHook);
}

Future<Null> remove(List<String> hooksToRemove) async {
  if (hooksToRemove[0] == 'all') {
    return hooks.forEach(removeHook);
  }
  return hooks.where((h) => hooksToRemove.contains(h)).forEach(removeHook);
}

Future<Null> createHook(String hookName, {hooksDirectory: '.git/hooks'}) async {
  print('Installing hook: $hookName');
  final hookFile = new File('$hooksDirectory/$hookName');

  if (!hookFile.existsSync()) {
    hookFile.create(recursive: true);
    print(hookFile.path);
  } else {
    final backup = new File('$hooksDirectory/$hookName.bak');
    if (!backup.existsSync()) {
      backup.writeAsStringSync(hookFile.readAsStringSync());
    }
  }
  final cmd = new CommandWrapper('bash');
  await cmd.run(['-c', 'chmod +x ${hookFile.path}']);

  hookFile.writeAsStringSync(getHookScript(hookName.replaceAll('-', '_')));
}

Future<Null> removeHook(String hookName, {hooksDirectory: '.git/hooks'}) async {
  print('Removing hook: $hookName');
  final hookFile = new File('$hooksDirectory/$hookName');
  hookFile.deleteSync();
}

getHookScript(String hookName) => '''
#!/bin/bash
# Created by hanzo

if [ ! -f ./tool/${hookName}.dart ]; then
    # Dart script not found, skipping hook"
    exit 0
fi

echo "> Running ${hookName} hook..."

DART_EXIT_CODE=0
dart ./tool/${hookName}.dart "\$@"
DART_EXIT_CODE=\$?


if [[ \${DART_EXIT_CODE} -ne 0 ]]; then
  echo ""
  echo "> Error detected in $hookName hook."
	exit 1
fi

''';

const hooks = const [
  "applypatch-msg",
  "pre-applypatch",
  "post-applypatch",
  "pre-commit",
  "prepare-commit-msg",
  "commit-msg",
  "post-commit",
  "pre-rebase",
  "post-checkout",
  "post-merge",
  "pre-push",
  "pre-receive",
  "update",
  "post-receive",
  "post-update",
  "push-to-checkout",
  "pre-auto-gc",
  "post-rewrite"
];
