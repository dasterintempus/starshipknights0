def build(s)
  puts `gem uninstall #{s} -a`
  output = `gem build #{s}.gemspec`
  puts output
  code = $?.exitstatus
  return code if code != 0
  gempath = "./"
  output.split.each do |word|
    if word.include? ".gem" then
      gempath += word
      break
    end
  end

  output = `gem install #{gempath}`
  puts output
  return $?.exitstatus
end

def build_game
  code = build("starshipknights")
  puts `ocra --no-enc starshipknights0.rbw -- prof`
  puts "Done building" if code == 0
  puts "Error building" if code != 0
end

#
# MAIN
#

build_game
