load '../Rakefile.local' if File.exist?('../Rakefile.local')
require 'fileutils'
desc "Build a Docker container from this repo."
task :prepare_fixtures do
  git_repo = ENV['GIT_REPO'].chomp.strip.split(/\//)
  FileUtils.rm_rf(git_repo[1]) if File.exist?(git_repo[1])
  sh %(git clone https://github.com/#{git_repo[0]}/#{git_repo[1]})
end
