user1 = User.create(email: 'user1@example.com', password: 'password')
user2 = User.create(email: 'user2@example.com', password: 'password')

pet1 = Pet.create(animal: 'dog', is_mix?: 'false', age: 2, name: 'Mack',
  size: 'XL', sex: 'M', description: 'Also a bear',
  status: 'Unavailable', good_with_dogs: true, good_with_cats: true,
  good_with_kids: true, breeds: [Breed.create(name: 'Mastiff')])

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

question1 = Question.create(body: 'A question', input_type: 1)
application_form1 = ApplicationForm.create(name:'A form!')
application_form1.questions = [question1]

breed1 = Breed.create(name: 'Rottweiler')
breed2 = Breed.create(name: 'Potato')

pet2 = Pet.create(animal: 'dog', is_mix?: true, age: 'Adult', name: 'Boomer',
  size: 'XL', sex: 'Male', description: 'A bear a bear a bear a bear a bear a bear a bear a bear a bear a bear a bear a bear a bear a bear a bear a bear a bear a bear',
  status: 'Unavailable', good_with_dogs: true, good_with_cats: false,
  organization_id: organization2.id, breeds: [breed1, breed2],
  adoption_application_id: application_form1.id,
  foster_application_id: application_form1.id)

question2 = Question.create(body: 'Question 1', input_type: 1)
question3 = Question.create(body: 'Question 2', input_type: 2)
application_form2 = ApplicationForm.create(name:'Adopt this bear')
application_form2.questions = [question2, question3]

answer1 = Answer.new(body: 'An answer', question_id: question1.id)
question1.answers = [answer1]

petApplication1 = PetApplication.create(pet: pet1, organization: pet1.organization, user: user1, questions: [question1])
petApplication2 = PetApplication.create(pet: pet2, organization: pet2.organization, user: user1, questions: [question1])
