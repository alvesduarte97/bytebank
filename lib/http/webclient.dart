//import 'package:http_interceptor/http_interceptor.dart';

import 'package:bytebank02/http/interceptors/logging-interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
