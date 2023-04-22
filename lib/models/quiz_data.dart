/*
    2     -> multiplier
  x 5     -> Multiplicand

*/

// For 25 / 5 = 5, 25 is the divident, 5 is the divisor and the answer 5 is the quotent
class QuizItem {
  int multiplicand;
  int correctAnswer;
  int answerGiven = 0;
  bool isCorrect = false;

  QuizItem(this.multiplicand, this.correctAnswer);
  @override
  String toString() {
    return "multiplicand : $multiplicand, correctAnswer: $correctAnswer answerGiven: $answerGiven";
  }
}

class QuizData {
  int multiplier = 6;
  List<QuizItem> quizItems;
  QuizData(this.multiplier, this.quizItems);
}
