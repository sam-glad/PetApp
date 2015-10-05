user1 = User.create(email: 'user1@example.com', password: 'password')
user2 = User.create(email: 'user2@example.com', password: 'password')

pet1 = Pet.create(animal: 'dog', is_mix?: 'false', age: 2, name: 'Boomer',
  size: 'XL', sex: 'M', description: 'A bear',
  status: 'Unavailable', good_with_dogs: true, good_with_cats: false,
  good_with_kids: true)

organization1 = Organization.create(name: 'Worcester Saint Bernard Rescue',
                                    city: 'Worcester',
                                    state_province: 'Massachusetts',
                                    phone_number: '5081234567',
                                    phone_extension: '90',
                                    country: 'United States',
                                    website: 'http://www.example.com/worcestersaints',
                                    email_address: 'worcestersaints@example.com',
                                    phone_preferred: false
                                    )

organization2 = Organization.create(name: 'Boston Mastiff Rescue',
                                    city: 'Boston',
                                    state_province: 'Massachusetts',
                                    phone_number: '6171234567',
                                    phone_extension: '09',
                                    country: 'United States',
                                    website: 'http://www.example.com/bostonmastiffs',
                                    email_address: 'bostonmastiffs@example.com',
                                    phone_preferred: true
                                    )

user1.organizations = [organization1, organization2]
user2.organizations = [organization2]
organization1.pets = [pet1]

question1 = Question.create(body: 'A question', input_type: 2)
application_form = ApplicationForm.create(name:'A form!')
application_form.questions = [question1]
