#!/usr/bin/env ruby
require 'net/ssh'

puts "Welcome to the Remote File Management Program!"
puts "Enter the hostname or IP address of the remote server:"
host = gets.chomp
puts "Enter the username for the remote server:"
user = gets.chomp
print "Enter the password for the remote server: "
password = gets.chomp

Net::SSH.start(host, user, :password => password) do |ssh|
  puts "Connected to #{host} as #{user}."
  puts "What would you like to do?"
  puts "1. List files in a directory"
  puts "2. Create a new file"
  puts "3. Delete a file"

  choice = gets.chomp.to_i

  if choice == 1
    puts "Enter the name of the directory:"
    dir_name = gets.chomp
    result = ssh.exec!("ls #{dir_name}")
    puts "Files in #{dir_name}:"
    puts result
  elsif choice == 2
    puts "Enter the name of the file to create:"
    file_name = gets.chomp
    result = ssh.exec!("touch #{file_name}")
    puts "File #{file_name} created successfully."
  elsif choice == 3
    puts "Enter the name of the file to delete:"
    file_name = gets.chomp
    result = ssh.exec!("rm #{file_name}")
    puts "File #{file_name} deleted successfully."
  else
    puts "Invalid choice. Please try again."
  end
end
