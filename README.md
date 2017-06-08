# hanzo

A library to easily use git hooks from Dart

## Install

To start using hanzo, add it to your `dev_dependencies`

To install hooks in your project, run:

    $ pub run hanzo install
    
Now create a matching git hook dart file in `./tool` directory (create if needed).
    
Example:
    
    // in ./tool/pre_commit.dart
    main(List<String> arguments) => 
        print("I'll run before a commit is made!");

    // in ./tool/commit_msg.dart
    main(List<String> arguments) => 
        print("I'll run after commit message is entered!");


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/andresaraujo/hanzo/issues
