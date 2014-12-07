require "bundler/gem_tasks"

rule '.rb' => '.y' do |t|
  sh "racc -l -o #{t.name} #{t.source}"
end

task :compile => 'lib/chessmate/parser.rb'

task :test => :compile