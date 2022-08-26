require "faker"

Message.destroy_all
Conversation.destroy_all
Contact.destroy_all
UserContact.destroy_all
User.destroy_all

puts " "
puts "Creating first user ..."
user_first = User.create!(first_name: "Deborah", last_name: "Martin", phone_number: "0760637308", password_digest: "deborah")
puts "------"
puts "Finish"
puts " "

puts "Creating 30 contacts and adding to user_contacts ..."
30.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: 8.times.map { rand(10) }.join.insert(0, "06"),
    password_digest: "secret",
  )
  user_contact = UserContact.create!(user_id: user.id)

  Contact.create!(
    user: user_first,
    user_contact: user_contact,
  )
end
puts "------"
puts "Finish"
puts " "

puts "Creating First Conversation with a message from user_first"
conversation = Conversation.create!(user: user_first, user_contact: UserContact.find(UserContact.pluck(:id).sample))
Message.create!(conversation: conversation, user: user_first, content: "Coucou, comment vas-tu ?")
puts "Finish"
puts " "
puts "------"
puts "You can run the application :)"
puts "------"
