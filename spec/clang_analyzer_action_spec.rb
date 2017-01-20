describe Fastlane::Actions::ClangAnalyzerAction do
  describe '#run' do
    it 'copies report to given folder if there are some bugs' do
      expected_command =
        "/analyzer/bin/scan-build xcodebuild" \
        " -project TestProject.xcodeproj" \
        " -scheme TestScheme" \
        " -configuration Debug" \
        " -sdk iphonesimulator" \
        " -arch i386" \
        " clean" \
        " analyze" \
        " | tee /log_file_path" \
        " | xcpretty"

      fake_output = File.read('./spec/fixtures/scan-build_output_fixture')
      expect(FastlaneCore::CommandExecutor).to receive(:execute).with(hash_including(command: expected_command))
      expect(File).to receive(:read).with('/log_file_path').and_return(fake_output)
      allow(FileUtils).to receive(:mkdir_p) {}
      expect(FileUtils).to receive(:rm_rf).with('/report_output_path')
      expect(FileUtils).to receive(:cp_r).with('/var/folders/fake_report_path', '/report_output_path')

      Fastlane::FastFile.new.parse("lane :test do
              clang_analyzer(project: 'TestProject.xcodeproj',
              scheme: 'TestScheme',
              analyzer_path: '/analyzer/bin',
              configuration: 'Debug',
              log_file_path: '/log_file_path',
              report_output_path: '/report_output_path')
      end").runner.execute(:test)
    end

    it 'removes output folder if there are no bugs' do
      expected_command =
        "/analyzer/bin/scan-build xcodebuild" \
        " -project TestProject.xcodeproj" \
        " -scheme TestScheme" \
        " -configuration Debug" \
        " -sdk iphonesimulator" \
        " -arch i386" \
        " clean" \
        " analyze" \
        " | tee /log_file_path" \
        " | xcpretty"

      fake_output = File.read('./spec/fixtures/scan-build_output_fixture_no_bugs')
      expect(FastlaneCore::CommandExecutor).to receive(:execute).with(hash_including(command: expected_command))
      expect(File).to receive(:read).with('/log_file_path').and_return(fake_output)
      allow(FileUtils).to receive(:mkdir_p) {}
      expect(FileUtils).to receive(:rm_rf).with('/report_output_path')
      expect(FileUtils).not_to receive(:cp_r)

      Fastlane::FastFile.new.parse("lane :test do
              clang_analyzer(project: 'TestProject.xcodeproj',
              scheme: 'TestScheme',
              analyzer_path: '/analyzer/bin',
              configuration: 'Debug',
              log_file_path: '/log_file_path',
              report_output_path: '/report_output_path')
      end").runner.execute(:test)
    end
  end
end
