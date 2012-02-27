#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

namespace :check_syntax do
  require 'erb'
  require 'open3'
  require 'yaml'

  desc "Check syntax of various file types"
  task :all => [:ruby, :erb, :yaml, :haml, :haml_ruby, :sass]

  #desc 'Check syntax of .erb and .rhtml files'
  task :erb do
    (Dir["**/*.erb"] + Dir["**/*.rhtml"]).each do |file|
      next if skip_path?(file)

      Open3.popen3('ruby -Ku -c') do |stdin, stdout, stderr|
        stdin.puts(ERB.new(File.read(file), nil, '-').src)
        stdin.close
        if error = ((stderr.readline rescue false))
          puts red_string(file) + error[1..-1].sub(/^[^:]*:\d+: /, '')
        end
        stdout.close rescue false
        stderr.close rescue false
      end
    end
  end

  #desc 'Check syntax of .haml files'
  task :haml do
    haml = bin_path "haml"
    Dir['**/*.haml'].each do |file|
      next if skip_path?(file)
      next if file.match("vendor/plugins/.*/generators/.*/templates")

      Open3.popen3("#{haml} -c #{file}") do |stdin, stdout, stderr|
        if error = ((stderr.readline rescue false))
          puts red_string(file) + error
        end
        stdin.close rescue false
        stdout.close rescue false
        stderr.close rescue false
      end
    end
  end

  #desc 'Check ruby syntax of .haml files'
  task :haml_ruby do
    Dir['**/*.haml'].each do |file|
      next if skip_path?(file)
      next if file.match("vendor/plugins/.*/generators/.*/templates")

      Open3.popen3("ruby -Ku -c") do |stdin, stdout, stderr|
        stdin.puts(Haml::Engine.new(File.read(file)).precompiled)
        stdin.close
        if error = ((stderr.readline rescue false))
          puts red_string(file) + error.sub(/^[^:]*:\d+: /, '')
        end
        stdout.close rescue false
        stderr.close rescue false
      end
    end
  end

  #desc 'Check syntax of .rb files'
  task :ruby do
    Dir['**/*.rb'].each do |file|
      next if skip_path?(file)
      next if file.match("vendor/plugins/.*/generators/.*/templates")

      Open3.popen3("ruby -Ku -c #{file}") do |stdin, stdout, stderr|
        if error = ((stderr.readline rescue false))
          puts error
        end
        stdin.close rescue false
        stdout.close rescue false
        stderr.close rescue false
      end
    end
  end

  #desc 'Check syntax of .sass files'
  task :sass do
    sass = bin_path "haml", "sass"
    Dir['**/*.sass'].each do |file|
      next if skip_path?(file)
      next if file.match("vendor/plugins/.*/generators/.*/templates")

      Open3.popen3("#{sass} -c #{file}") do |stdin, stdout, stderr|
        if error = ((stderr.readline rescue false))
          puts error
        end
        stdin.close rescue false
        stdout.close rescue false
        stderr.close rescue false
      end
    end
  end

  #desc 'Check syntax of .yml files'
  task :yaml do
    Dir['**/*.yml'].each do |file|
      next if skip_path?(file)

      begin
        YAML.load_file(file)
      rescue => e
        puts red_string(file) + "#{(e.message.match(/on line (\d+)/)[1] + ':') rescue nil} #{e.message}"
      end
    end
  end

  def bin_path gem_name, bin_name=nil
    bin_name=gem_name if bin_name.nil?
    [`bundle show #{gem_name}`.chomp!, 'bin', bin_name].join("/")
  end

  def skip_path?(file)
    ["tmp", "vendor/gems", "vendor/rails"].each do |dir|
      return true if file.match(dir)
    end
    return false
  end

  def red_string(str)
    "\e[31m" + str + "\e[0m: "
  end
end