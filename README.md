# clang_analyzer plugin

[![CI Status](http://img.shields.io/travis/SiarheiFedartsou/fastlane-plugin-clang_analyzer.svg?style=flat)](https://travis-ci.org/SiarheiFedartsou/fastlane-plugin-clang_analyzer)
[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-clang_analyzer)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-clang_analyzer`, add it to your project by running:

```bash
fastlane add_plugin clang_analyzer
```

Then you need to download standalone [Clang Static Analyzer](http://clang-analyzer.llvm.org/).
By default plugin will look for analyzer at ~/analyze_tools.
To run Clang Static Analyzer add `clang_analyzer` action call in one of lanes in your Fastfile.

## About clang_analyzer

Runs [Clang Static Analyzer](http://clang-analyzer.llvm.org/) on your codebase and generates report.

## Example

Check out the [example `Fastfile`](example/fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test` in `./example` folder. Example of analyzer report can be found [here](example/fastlane/analyze_report).

## Actions

### clang_analyzer
```ruby
clang_analyzer(
  analyzer_path: '~/analyze_tools/bin', # optional
  workspace: 'Test.xcworkspace', # optional, cannot be used together with `project` option
  project: 'Test.xcodeproj', # optional, cannot be used together with `workspace` option
  configuration: 'Debug', # optional
  sdk: 'iphonesimulator', # optional
  arch: 'i386', # optional
  report_output_path: './fastlane/analyze_report/' # optional
  )
```


## Jenkins integration

You can easily integrate this plugin to Jenkins using [Jenkins HTML Publisher Plugin](https://wiki.jenkins-ci.org/display/JENKINS/HTML+Publisher+Plugin). Just pass path to generated report to this plugin.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/PluginsTroubleshooting.md) doc in the main `fastlane` repo.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Plugins.md).

## About `fastlane`

`fastlane` is the easiest way to automate building and releasing your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
