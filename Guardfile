# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Uncomment and set this to only include directories you want to watch
#
# directories %(app lib config test spec feature)

guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
end
