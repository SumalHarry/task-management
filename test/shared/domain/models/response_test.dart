import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/dummy_data.dart';

void main() {
  test(
    'toString() function returns the objects',
    () {
      final expectedString =
          'statusCode=${ktestResponse.statusCode}\nstatusMessage=${ktestResponse.statusMessage}\n data=${ktestResponse.data}';

      final actual = ktestResponse.toString();

      expect(actual, expectedString);
    },
  );
}
