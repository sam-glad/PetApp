user1 = User.create(email: 'user@example.com', password: 'password')
organization1 = Organization.create(name: 'Worcester Saint Bernard Rescue')

user1.organizations = [organization1]
organization1.users = [user1]
