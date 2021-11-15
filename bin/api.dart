import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Api {
  Handler get handler {
    final router = Router();

    // Write your logic here
    router.get('/api/<name>', (Request request,String name) {
      return Response.ok(
        jsonEncode({
          'success':true,
          'data':name
        })
      );
    });

    return router;
  }
}