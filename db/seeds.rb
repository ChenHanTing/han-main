# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(username:"chenruru", password:"1234567890", email: "wss200086@gmail.com")
User.create(username:"chenhanhan", password:"1234567890", email: "han@jvdiamondtech.com")

LabForum.create(question: "First Question", description: "Default Description", category: "others", user: User.first)
LabForum.create(question: "Second Question", description: "Default Description", category: "others", user: User.second)

Comment.create(content: "First Content", commentable: LabForum.first, user: User.first)
Comment.create(content: "Second Content", commentable: LabForum.first, user: User.second)
Comment.create(content: "Third Content", commentable: LabForum.second, user: User.first)
Comment.create(content: "Forth Content", commentable: LabForum.second, user: User.second)

Like.create(expression: 1, expressable: LabForum.first, user: User.first)
Like.create(expression: 1, expressable: LabForum.first, user: User.second)
