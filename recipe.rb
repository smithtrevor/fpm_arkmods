require 'yaml'
require 'pp'

class ArkMod < FPM::Cookery::DirRecipe

  config = YAML::load(File.open('config.yaml'))
  
  ENV.fetch('SOURCEDIR') {
    ENV['SOURCEDIR'] = config.fetch('source_dir') {
      puts "must specify source_dir key in config.yaml or set SOURCEDIR env variable"
      exit(1)
    }
  }

  ENV.fetch('TARGETDIR') {
    ENV['TARGETDIR'] = config.fetch('target_dir') {
      puts "must specify target_dir key in config.yaml or set TARGETDIR env variable"
      exit(1)
    }
  }

  mods = config.fetch('mods') {
    puts 'no "mods" section in config.yaml'
    exit(1)
  }
  
  mod_name = ENV.fetch("MODNAME") {
    puts 'must specify MODNAME environment variable'
    exit(1)
  }
  
  mod_data = mods.fetch(mod_name) {
    puts "#{mod_name} doesn't match any keys in mods.yaml"
    exit(1)
  }
  
  mod_id = mod_data.fetch('id') {
    puts "id key not found for #{mod_name}"
    exit(1)
  }
  ENV["MODID"] = mod_id.to_s
  
  mod_version =ENV.fetch("VERSION") {
    puts 'must specify VERSION environment variable'
    exit(1)
  }
  
  package_revision = ENV.fetch("REV") {
    puts 'REV environment variable not specified defaulting to 0'
    0
  }
  
  name "ark_mod_#{mod_name}"
  version mod_version
  revision package_revision
  source ENV.fetch('SOURCEDIR'), :with => :directory

  section 'Entertainment/Ark'

  def install
    mod = ENV.fetch('MODID')
    mod_dir = ENV.fetch('TARGETDIR')
    destdir("#{mod_dir}").install_p "#{mod}"
    destdir("#{mod_dir}").install_p "#{mod}.mod"
  end
end
