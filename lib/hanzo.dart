library hanzo;

import 'dart:async';
import 'dart:io';

Future<void> install(Hooks hookToAdd, {bool addPrecommitSample: false}) async {
  if (hookToAdd == Hooks.all) {
    Hooks.values.forEach(createHook);
  }

  createHook(hookToAdd);

  if (addPrecommitSample) {
    print('Creating pre-commit Dart script sample');
    createDartScripSample();
  }
}

void createDartScripSample() {
  final dartFile = new File('./tool/pre_commit.dart');
  if (dartFile.existsSync()) {
    return;
  }

  dartFile.createSync(recursive: true);
  dartFile.writeAsStringSync(dartPrecommitSample);
}

Future<void> remove(Hooks hookToRemove) async {
  if (hookToRemove == Hooks.all) {
    return Hooks.values.forEach(removeHook);
  }
  return removeHook(hookToRemove);
}

Future<void> createHook(Hooks hook,
    {String hooksDirectory: '.git/hooks'}) async {
  final hookName =
      hook.toString().replaceAll('Hooks.', '').replaceAll('_', '-');
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
  await Process.start('bash', ['-c', 'chmod +x ${hookFile.path}'],
      runInShell: true);

  hookFile.writeAsStringSync(getHookScript(hookName.replaceAll('-', '_')));
}

Future<void> removeHook(Hooks hook,
    {String hooksDirectory: '.git/hooks'}) async {
  final hookName =
      hook.toString().replaceAll('Hooks.', '').replaceAll('_', '-');
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

enum Hooks {
  all,
  applypatch_msg,
  commit_msg,
  post_applypatch,
  post_checkout,
  post_commit,
  post_merge,
  post_receive,
  post_rewrite,
  post_update,
  pre_applypatch,
  pre_auto_gc,
  pre_commit,
  pre_push,
  pre_rebase,
  pre_receive,
  prepare_commit_msg,
  push_to_checkout,
  update,
}

const dartPrecommitSample = '''

main(List<String> arguments) {
  print('This Dart script will run before a commit!');
}

''';
