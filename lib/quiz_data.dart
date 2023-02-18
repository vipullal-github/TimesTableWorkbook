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
