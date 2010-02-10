Given /^I'm using Ruby (.*) and Rails (.*)$/ do |ruby_version, rails_version|
  @commands = Commands.new(ruby_version, rails_version)
end

Given /^a Rails 2 app "(.*)"$/ do |app_name|
  @rails_app = @commands.new_rails_2_app(app_name)
end

Given /^a Rails 3 app "(.*)"$/ do |app_name|
  @rails_app = @commands.new_rails_3_app(app_name)
end

When /^I run "script\/(.*)" in the app$/ do |command|
  @rails_app.script(command)
end

When /^I run "rails (.*)" in the app$/ do |command|
  @rails_app.rails(command)
end

Then /^I get the following new files and directories$/ do |files|
  expected_files = files.hashes.collect { |row| row[:name] }
  @rails_app.should have_files(expected_files)
end

Then /^the files are configured for (?:.*)$/ do |files|
  files.hashes.each do |file|
    @rails_app.file(file[:name]).should have_contents(file[:contents])
  end
end