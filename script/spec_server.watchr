def jessie
  system('./script/run_server_specs.sh') 
  puts "====================="
end

watch('spec/server/.*\.coffee') { jessie() }
watch('server/.*\.coffee') { jessie() }


