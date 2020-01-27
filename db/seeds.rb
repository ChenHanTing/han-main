# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Idea.create(
  [
    {
      title: 'A new cake recipe',
      body: 'Made of chocolate'
    },
    {
      title: 'A twitter client idea',
      body: 'Only for replying to mentions and DMs'
    },
    {
      title: 'A novel set in Italy',
      body: 'A mafia crime drama starring Berlusconi'
    },
    {
      title: 'Card game design',
      body: 'Like Uno but involves drinking'
    }
  ]
)

User.create(username: 'chenruru', password: 'as789123456',
            email: 'wss200086@gmail.com', admin: true)
User.create(username: 'chenhanhan', password: 'as789123456',
            email: 'han@jvdiamondtech.com', admin: true)

LabForum.create(question: 'First Question', description: 'Default Description',
                category: 'others', user: User.first)
LabForum.create(question: 'Second Question', description: 'Default Description',
                category: 'others', user: User.second)

Comment.create(content: 'First Content', commentable: LabForum.first,
               user: User.first)
Comment.create(content: 'Second Content', commentable: LabForum.first,
               user: User.second)
Comment.create(content: 'Third Content', commentable: LabForum.second,
               user: User.first)
Comment.create(content: 'Forth Content', commentable: LabForum.second,
               user: User.second)

Like.create(expression: 1, expressable: LabForum.first,
            user: User.first)
Like.create(expression: 1, expressable: LabForum.first,
            user: User.second)

Todo.create(content: 'Wash the face', user: User.first,
            complete_time: Time.current)
Todo.create(content: 'Shower', user: User.first,
            complete_time: Time.current)
Todo.create(content: 'Learning Ruby on Rails', user: User.second,
            complete_time: Time.current)
