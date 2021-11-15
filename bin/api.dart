import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Api {
  List data = jsonDecode(
    File('friends.json').readAsStringSync()
  )['users'];
  Handler get handler {
    final router = Router();

    // Write your logic here
    router.get('/api/<name>', (Request request,String name) {
      return Response.ok(
        jsonEncode({
          'success':true,
          'data':data
        })
      );
    });

    router.post('/api/add', (Request request) async{
      final payload = jsonDecode(await request.readAsString());
      data.add(payload);

      return Response.ok(
        jsonEncode({
          'success':true,
          'data':data
        }),
        headers: {
        'Content-type':'application/json'
        },
      );
    });


    return router;
  }
}