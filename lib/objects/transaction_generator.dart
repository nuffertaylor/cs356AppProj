import 'dart:math';
import 'package:faker/faker.dart';
import 'package:random_date/random_date.dart';
import 'transaction.dart';

class TransactionGenerator {
  static List<Transaction> generateFakeTransactions([numToGenerate = 10]) {
    List<Transaction> results = <Transaction>[];
    for (int i = 0; i < numToGenerate; i++) {
      Transaction t = generateFakeTransaction();
      results.add(t);
    }
    return results;
  }

  static generateFakeTransaction() {
    var rng = new Random();
    var faker = new Faker();
    return Transaction(
        RandomDate.withRange(2019, 2021).random(),
        faker.lorem.sentence(), "sender", "receiver",
        rng.nextInt(50) + rng.nextDouble() - 25);
  }
}