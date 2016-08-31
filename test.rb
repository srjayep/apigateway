require 'find'
module_path="~/development/mydev/apigatewaysr"
def copy_all_but_fixtures(source_path, target_path)

  skip_directories = [
      File.join('.tmp'),
      File.join('.librarian'),
      File.join('.vagrant'),
      File.join('.git'),
      File.join('builds'),
      File.join('common'),
      File.join('spec', 'fixtures'),
      File.join('packer_cache'),
  ]

  Find.find(source_path) do |source|
    target = source.sub(/^#{source_path}/, target_path)
    if File.directory? source
      Find.prune if skip_directories.any? { |f| source.end_with? f }
      FileUtils.mkdir target unless File.exists? target
    else
      FileUtils.copy source, target
    end
  end
end

# Copy current module into fixtures folder for testing
def copy_module (path, name)
  module_path = File.join(path, name)
  mkdir_p module_path
  copy_all_but_fixtures('.', module_path)
end
