import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:vaani/shared/extensions/obfuscation.dart';

final _logger = Logger('ErrorResponse');

class ErrorResponseHandler {
  String? name;
  http.Response _response;
  bool logRawResponse;

  ErrorResponseHandler({
    this.name,
    http.Response? response,
    this.logRawResponse = false,
  }) : _response = response ?? http.Response('', 418);

  void storeError(http.Response response, [Object? error]) {
    if (logRawResponse) {
      _logger.fine('for $name got response: ${response.obfuscate()}');
    }
    _response = response;
  }

  http.Response get response => _response;
}
