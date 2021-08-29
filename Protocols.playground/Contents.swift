import UIKit

class Question {
    var type: QuestionType
    var query: String
    var answer: String
    
    init(type: QuestionType, query: String, answer: String) {
        self.type = type
        self.query = query
        self.answer = answer
    }
    
}

enum QuestionType: String {
    case trueFalse = "The grass is green?"
    case multipleChoie = "Who is the first president of USA: John Adams, Andrew Jackson, George Washington or George Bush?"
    case shortAnswer = "What is the capital of Canada?"
    case essay = "Write a few sentences about how ARC works"
    
    static let types = [trueFalse, multipleChoie, shortAnswer, essay]
}

enum AnswerType: String {
    case trueFalse = "True"
    case multipleChoie = "George Washington"
    case shortAnswer = "Ottawa"
    case essay = "Every time you create a new instance of a class, ARC allocates a chunk of memory to store information about that instance. This memory holds information about the type of the instance, together with the values of any stored properties associated with that instance."
    
    static let types = [trueFalse, multipleChoie, shortAnswer, essay]
}

protocol QuestionGenerator {
     func generateRandomQuestion() -> Question
}

class Quiz: QuestionGenerator {
    func generateRandomQuestion() -> Question {
        let randomNumeral = Int(arc4random_uniform(4))
        let randomType = QuestionType.types[randomNumeral]
        let randomQuery = randomType.rawValue
        let randomAnswer = AnswerType.types[randomNumeral].rawValue
        let randomQuestion = Question(type: randomType, query: randomQuery, answer: randomAnswer)
        return randomQuestion
    }
}

let quiz = Quiz()

let question = quiz.generateRandomQuestion()

print("Question type: \(question.type) \nQuery: \(question.query) \nAnswer: \(question.answer)")
