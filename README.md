# hanzo

A library to easily use git hooks from Dart

## Install

To start using Hanzo, add it to your `dev_dependencies` and run `pub get`

To install hooks in your project, run:

    $ pub run hanzo install
        
Now create a matching git hook dart file in `./tool` directory (create if needed).
    
Example:
    
```dart
    // in ./tool/pre_commit.dart
    main(List<String> arguments) => 
        print("I'll run before a commit is made!");

    // in ./tool/commit_msg.dart
    main(List<String> arguments) => 
        print("I'll run after commit message is entered!");
```
        

### Install options

| Option/Flag | abbreviation | description |
| -------- | ---------- | ---------- |
| `--precommit-sample` | none | If flag is passed it will create a sample pre commit Dart script. Defaults to `false` |
| `--hook <hook-name>` | -k | Creates a bash script for the hook passed, supports passing multiple hooks. Defaults to `all` scripts. Example: `-k pre-commit -k commit-message` |

## Remove

To remove all hooks in your project, run:

    $ pub run hanzo remove
    
Or if you want to remove a specific hook:
    
    $ pub run hanzo remove -k pre-commit -k commit-msg

## Git Hooks

Git hooks are scripts that run automatically every time a particular event occurs in a Git repository. 
Hanzo supports all git hooks (https://git-scm.com/docs/githooks)

| Git hook | Dart script name |
| -------- | ---------- |
| applypatch-msg | applypatch_msg.dart |
| commit-msg | commit_msg.dart |
| post-applypatch | post_applypatch.dart |
| post-checkout | post_checkout.dart |
| post-commit | post_commit.dart |
| post-merge | post_merge.dart |
| post-receive | post_receive.dart |
| post-rewrite | post_rewrite.dart |
| post-update | post_update.dart |
| pre-applypatch | pre_applypatch.dart |
| pre-auto-gc | pre_auto_gc.dart |
| pre-commit | pre_commit.dart |
| pre-push | pre_push.dart |
| pre-rebase | pre_rebase.dart |
| pre-receive | pre_receive.dart |
| prepare-commit-msg | prepare_commit_msg.dart |
| push-to-checkout | push_to_checkout.dart |
| update | update.dart |

### Accessing Git params

Git params will be passed as arguments to the main function of the Dart script.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/andresaraujo/hanzo/issues
