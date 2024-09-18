import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

final _logger = Logger('ErrorResponse');

class ErrorResponseHandler {
  String? name;
  http.Response _response;

  ErrorResponseHandler({
    this.name,
    http.Response? response,
  }) : _response = response ?? http.Response('', 418);

  void storeError(http.Response response, [Object? error]) {
    _logger.fine('for $name got response: $response');
    _response = response;
  }

  http.Response get response => _response;
}