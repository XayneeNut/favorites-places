import 'dart:math';

class RandomIntId{
  int gusantaIdGen() {
    Random random = Random();
    int randomNumber = random.nextInt(90000) + 1000;
    return randomNumber;
  }
}