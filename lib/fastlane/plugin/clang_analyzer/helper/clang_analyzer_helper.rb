module Fastlane
  module Helper
    class ClangAnalyzerHelper
      # class methods that you define here become available in your action
      # as `Helper::ClangAnalyzerHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the clang_analyzer plugin helper!")
      end
    end
  end
end
