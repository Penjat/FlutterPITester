class PiTest {
  bool hasLost = false;
  int startingDigit = 0;
  int currentDigit = 0;
  bool checkCorrect(int number) {
    return pi_string[currentDigit] == number.toString();
  }

  addCorrect() {
    currentDigit++;
  }

  reset() {
    hasLost = false;
    startingDigit = 0;
    currentDigit = 0;
  }

  String correctDigits() {
    return pi_string.substring(0,currentDigit);
  }
}

const String pi_string = """
1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482
""";