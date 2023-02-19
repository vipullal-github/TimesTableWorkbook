// With 5 x 4 = 20, 5 is the multiplicand and 4 is the multiplier and 20 is the product
// For 25 / 5 = 5, 25 is the divident, 5 is the divisor and the answer 5 is the quotent
class QuizItem {
  int multiplicand;
  int correctAnswer;
  int answerGiven = 0;

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
