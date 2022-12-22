user0 = User.create({ email: 'teacher@example.com',
                      password: 12345678,
                      role: 0 })

test0 = Test.create(
  name: "Math 1",
  description: "Take a Math test",
  user_id: user0.id)

question0 = Question.create(name: "Simple Algebra",
                         description: "What is 2 + 2?",
                         test_id: test0.id,
                         user_id: user0.id)

Option.create(
  description: "The result is 2",
  answer: false,
  question_id: question0.id,
  user_id: user0.id)

Option.create(
  description: "The result is 4",
  answer: true,
  question_id: question0.id,
  user_id: user0.id)

Option.create(
  description: "The result is 0",
  answer: false,
  question_id: question0.id,
  user_id: user0.id)

test1 = Test.create(name: "English 1",
                    description: "Test your English skills 1",
                    user_id: user0.id)

question1 = Question.create(name: "Simple_english",
                         description: "What is meaning of life?",
                         test_id: test1.id,
                         user_id: user0.id)

Option.create(
  description: "The answer is 42",
  answer: true,
  question_id: question1.id,
  user_id: user0.id)

Option.create(
  description: "The answer is 88",
  answer: false,
  question_id: question1.id,
  user_id: user0.id)

Option.create(
  description: "The answer is 103",
  answer: false,
  question_id: question1.id,
  user_id: user0.id)


test2 = Test.create(name: "English 2",
                    description: "Test your English skills 2",
                    user_id: user0.id)


question2 = Question.create(name: "Simple_english",
                         description: "is apple fruit ?",
                         test_id: test2.id,
                         user_id: user0.id)

Option.create(
  description: "fruit",
  answer: true,
  question_id: question2.id,
  user_id: user0.id)

Option.create(
  description: "vegetable",
  answer: false,
  question_id: question2.id,
  user_id: user0.id)
