import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'intercepts/intercept.dart';

const String baseUrl = 'http://192.168.15.29:8000/';

final Client client = HttpClientWithInterceptor.build(interceptors: [
  LoggingInterceptor()
]);