// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hanzo.dart';

// **************************************************************************
// CliGenerator
// **************************************************************************

T _$enumValueHelper<T>(String enumName, List<T> values, String enumValue) =>
    enumValue == null
        ? null
        : values.singleWhere((e) => e.toString() == '$enumName.$enumValue',
            orElse: () => throw new StateError(
                'Could not find the value `$enumValue` in enum `$enumName`.'));

Options _$parseOptionsResult(ArgResults result) =>
    new Options(result['add-sample'] as bool,
        installWasParsed: result.wasParsed('install'),
        removeWasParsed: result.wasParsed('remove'))
      ..install =
          _$enumValueHelper('Hooks', Hooks.values, result['install'] as String)
      ..remove =
          _$enumValueHelper('Hooks', Hooks.values, result['remove'] as String);

ArgParser _$populateOptionsParser(ArgParser parser) => parser
  ..addFlag('add-sample',
      abbr: 's',
      help: 'If set, creates dummy dart script for the git hook',
      defaultsTo: false)
  ..addOption('install',
      abbr: 'i',
      help: 'Creates git hooks scripts in .git/hook .',
      defaultsTo: 'pre_commit',
      allowed: [
        'all',
        'applypatch_msg',
        'commit_msg',
        'post_applypatch',
        'post_checkout',
        'post_commit',
        'post_merge',
        'post_receive',
        'post_rewrite',
        'post_update',
        'pre_applypatch',
        'pre_auto_gc',
        'pre_commit',
        'pre_push',
        'pre_rebase',
        'pre_receive',
        'prepare_commit_msg',
        'push_to_checkout',
        'update'
      ])
  ..addOption('remove',
      abbr: 'r',
      help: 'Removes git hooks scripts in .git/hook .',
      defaultsTo: 'all',
      allowed: [
        'all',
        'applypatch_msg',
        'commit_msg',
        'post_applypatch',
        'post_checkout',
        'post_commit',
        'post_merge',
        'post_receive',
        'post_rewrite',
        'post_update',
        'pre_applypatch',
        'pre_auto_gc',
        'pre_commit',
        'pre_push',
        'pre_rebase',
        'pre_receive',
        'prepare_commit_msg',
        'push_to_checkout',
        'update'
      ]);

final _$parserForOptions = _$populateOptionsParser(new ArgParser());

Options parseOptions(List<String> args) {
  var result = _$parserForOptions.parse(args);
  return _$parseOptionsResult(result);
}
