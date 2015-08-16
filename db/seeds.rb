user1 = User.create(email: 'user@example.com', password: 'password')
organization1 = Organization.create(name: 'Worcester Saint Bernard Rescue')

pet1 = Pet.create(animal: 'dog', mix: 'false', age: 2, name: 'Boomer',
  available_date: Time.now, size: 'XL', sex: 'M', weight: 135,
  description: 'A bear', status: 'Unavailable', good_with_dogs: true,
  good_with_cats: false, good_with_kids: true, fence_required: false,
  fence_height: 0, breed_experience_required: false)

user1.organizations = [organization1]
organization1.users = [user1]
organization1.pets = [pet1]
