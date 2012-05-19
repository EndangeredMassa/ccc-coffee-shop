def jessie
  system('./node_modules/jessie/bin/jessie spec/app -f nested') 
  puts "====================="
end

jessie()

watch('spec/app.*\.coffee') { jessie() }
watch('app/.*\.coffee') { jessie() }


