import 'package:flutter_test/flutter_test.dart';
import 'package:pickrr_app/src/helpers/utility.dart';

void main() {
  test('Calculate price for distances less than 1', () {
    expect(priceCalculator(0.5), 300.0);
    expect(priceCalculator(0), 300.0);
    expect(priceCalculator(0.4), 300.0);
    expect(priceCalculator(0.99), 300.0);
  });

  test('Calculate price for distances greater than 1', () {
    expect(priceCalculator(1), 300.0);
    expect(priceCalculator(4), 300.0);
    expect(priceCalculator(4.5), 300.0);
    expect(priceCalculator(4.9), 300.0);
    expect(priceCalculator(4.0), 300.0);
    expect(priceCalculator(5), 650.0);
    expect(priceCalculator(45), 3450.0);
    expect(priceCalculator(20), 1700.0);
  });
}