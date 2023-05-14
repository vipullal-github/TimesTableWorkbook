class QuizResults {
  DateTime dateTaken;
  int totalTimeTaken;
  int multiplier;
  int totalNumberOfQuestions;
  int currectAnswers;

  QuizResults(
      {required this.dateTaken,
      required this.totalTimeTaken,
      required this.multiplier,
      required this.totalNumberOfQuestions,
      required this.currectAnswers});

  factory QuizResults.fromJSON(Map<String, dynamic> data) {
    DateTime dt = data['dt'];
    int timeTaken = data['tt'];
    int multiplier = data['mu'];
    int numQuestions = data['nq'];
    int numCorrect = data['nc'];
    return QuizResults(
        dateTaken: dt,
        totalTimeTaken: timeTaken,
        multiplier: multiplier,
        totalNumberOfQuestions: numQuestions,
        currectAnswers: numCorrect);
  }
}
