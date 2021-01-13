import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

import 'intercepts/intercept.dart';

const String baseUrl = 'http://192.168.15.29:8000/';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);