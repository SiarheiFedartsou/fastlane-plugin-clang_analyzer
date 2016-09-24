module Fastlane
  module Actions
    class ClangAnalyzerAction < Action
      def self.run(params)
        unless Helper.test?
          FastlaneCore::Project.detect_projects(params)
          project = FastlaneCore::Project.new(params)
          project.select_scheme

          params[:configuration] = project.configurations[0] unless params[:configuration]
        end

        analyzer_params = []

        if params[:workspace]
          analyzer_params << "-workspace #{params[:workspace]}"
        end

        if params[:project]
          analyzer_params << "-project #{params[:project]}"
        end

        analyzer_params += [
          "-scheme", params[:scheme],
          "-configuration", params[:configuration],
          "-sdk", params[:sdk],
          "-arch", params[:arch]
        ]

        analyzer_params_string = analyzer_params.join(" ")

        begin
          output = Actions.sh(File.join(params[:analyzer_path], "scan-build") + " xcodebuild #{analyzer_params_string} clean analyze")

          resulting_path = params[:report_output_path]
          begin
            FileUtils.rm_rf(resulting_path)
          rescue
            nil
          end

          matches = output.match(/scan-view (.*)\'/)
          if matches
            path = output.match(/scan-view (.*)\'/)[1]
            FileUtils.cp_r(path, resulting_path)
            UI.success "Successfully generated analyzer report at path #{File.expand_path(resulting_path)}"
          else
            UI.success "No bugs found by analyzer report"
          end

        rescue => ex
          UI.error ex
          raise "Static Analyzer failed!".red
        end
      end

      def self.description
        "Runs Clang Static Analyzer(http://clang-analyzer.llvm.org/) and generates report"
      end

      def self.authors
        ["SiarheiFiedartsou"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :analyzer_path,
                                  env_name: "CLANG_ANALYZER_ANALYZER_PATH",
                                   optional: true,
                                  default_value: File.expand_path("~/analyze_tools/bin"),
                                  verify_block: proc do |value|
                                                  unless File.exist? value
                                                    UI.user_error!("Couldn't find clang analyzer tools.") unless Helper.test?
                                                  end
                                                end),
          FastlaneCore::ConfigItem.new(key: :workspace,
                                  env_name: "CLANG_ANALYZER_WORKSPACE",
                                   optional: true,
                                   conflicting_options: [:project],
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :project,
                                  env_name: "CLANG_ANALYZER_PROJECT",
                                  optional: true,
                                  conflicting_options: [:workspace],
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :scheme,
                                  env_name: "CLANG_ANALYZER_SCHEME",
                                  optional: true),
          FastlaneCore::ConfigItem.new(key: :configuration,
                                  env_name: "CLANG_ANALYZER_CONFIGURATION",
                                  optional: true),
          FastlaneCore::ConfigItem.new(key: :sdk,
                                  env_name: "CLANG_ANALYZER_SDK",
                                  optional: true,
                                  default_value: "iphonesimulator"),
          FastlaneCore::ConfigItem.new(key: :arch,
                                  env_name: "CLANG_ANALYZER_ARCH",
                                  optional: true,
                                  default_value: "i386"),
          FastlaneCore::ConfigItem.new(key: :report_output_path,
                                  env_name: "CLANG_ANALYZER_REPORT_OUTPUT_PATH",
                                  optional: true,
                                  default_value: "./fastlane/analyze_report/")

        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
