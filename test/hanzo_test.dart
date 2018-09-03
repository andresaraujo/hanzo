import 'dart:io';
import 'package:hanzo/hanzo.dart';
import 'package:test/test.dart';

main() async {
  await testCreateHook();
}

testCreateHook() async {
  test('Should create hook file', () async {
    final hookName = Hooks.pre_commit
        .toString()
        .replaceAll('Hooks.', '')
        .replaceAll('_', '-');
    final tmp = await Directory.systemTemp.createTemp('hanzo_git_temp_test');
    await createHook(Hooks.pre_commit, hooksDirectory: tmp.path);

    final file = new File('${tmp.path}/$hookName');
    expect(file.existsSync(), isTrue);

    final expectedCommand = 'dart ./tool/${hookName.replaceAll('-', '_')}.dart';
    expect(file.readAsStringSync().contains(expectedCommand), isTrue);

    await tmp.delete(recursive: true);
  });

  test('Should remove hook file', () async {
    final hookName = Hooks.pre_commit
        .toString()
        .replaceAll('Hooks.', '')
        .replaceAll('_', '-');
    final tmp = await Directory.systemTemp.createTemp('hanzo_git_temp_test');
    final file = new File('${tmp.path}/$hookName');
    file.createSync();

    await removeHook(Hooks.pre_commit, hooksDirectory: tmp.path);
    expect(file.existsSync(), isFalse);

    await tmp.delete(recursive: true);
  });
}
