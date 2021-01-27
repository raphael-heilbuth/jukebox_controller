import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'intercepts/intercept.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);