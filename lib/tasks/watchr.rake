desc "Run watchr"
task :watchr do
  sh %{bundle exec watchr /home/me/bin/watchr}
end
