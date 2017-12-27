namespace :db do
  task admin: :environment do
    puts "Make a admin"
    name = "Admin"
    email = "admin@awesome.staff"
    encrypted_password = ENV["GMAIL_PASSWORD"]
    staff_role = 0

    Staff.create! name: name, email: email,
      password: encrypted_password, staff_role: staff_role
  end
end
