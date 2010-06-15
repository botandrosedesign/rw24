# clear out rails 2.3's gems tasks if bundler is used for the current project
def bundler_used?
  File.exist? "Gemfile"
end

if bundler_used?
  Rake::Task[:gems].clear
  Rake::Task[:"gems:install"].clear
end
