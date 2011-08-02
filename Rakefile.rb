require 'rubygems'
require 'bundler'

Bundler.require

namespace :package do
  desc "Generate deb package"
  task :deb do
    root           = File.join(File.dirname(__FILE__))
    bin_name       = "stud"
    package_name   = "walk-server"
    package_dir    = "#{root}/packages"
    package_type   = "deb"
    version        = ENV["version"] || "1.0"
    setup_dir      = "/usr/local/bin/"
    deb_dir        = "#{package_dir}/deb"
    src_dir        = "#{package_dir}/source"
    type           = "dir"
    compile        = "make clean && make"
    post_install   = "#{package_dir}/post_install.sh"
    pre_uninstall  = "#{package_dir}/pre_uninstall.sh"

    FileUtils.mkdir_p(deb_dir)

    if system(compile)
      FileUtils.mv(bin_name, src_dir)
    else
      puts "Erro!!!"
    end

    fpm = <<-FPM
fpm --prefix=#{setup_dir} \
  -s #{type} \
  -v #{version} \
  -t #{package_type} \
  -n #{package_name} \
  -C #{src_dir} \
  -d 'riak' \
  --post-install=#{post_install} \
  --pre-uninstall=#{pre_uninstall} \
  -p #{package_name}.deb
    FPM

    if system(fpm)
      FileUtils.mv("#{package_name}.deb", deb_dir)
    end
  end
end
