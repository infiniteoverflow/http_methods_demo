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
        }),
        headers: {
          'Content-type':'application/json'
        },
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

    router.delete('/api/delete/<id>', (Request request, String id) {
      final idN = int.parse(id);
      final deletedData = data.firstWhere(
        (element) => element['id']==idN,
        orElse: ()=> null
      );

      if(deletedData==null) {
        return Response.notFound(
          jsonEncode({
            'success':false,
            'data':'invalid id'
          }),
          headers: {
            'Content-type': 'application/json'
          },
        );
      }

      int pos = deletedData['id'];
      data.removeAt(pos-1);

      return Response.ok(
        jsonEncode({
          'success':true,
          'data':data
        }),
        headers: {
          'Content-type':'application/json'
        }
      );
    });


    return router;
  }
}