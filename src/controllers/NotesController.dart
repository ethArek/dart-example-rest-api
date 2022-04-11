import 'dart:convert';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_plus/shelf_plus.dart';


import '../dependencies/Dependencies.dart';
import '../modules/note/NoteModule.dart';

class NotesController {
  Dependencies dependencies;

  NotesController(this.dependencies);

  Router get router {
    final router = Router();

    router.get('/', (Request req) async {
      int limit;
      int offset;

      var limitQueryParam = req.url.queryParameters['limit'];
      var offsetQueryParam = req.url.queryParameters['offset'];

      if (limitQueryParam != null) {
        limit = int.parse(limitQueryParam);
      } else {
        limit = 20;
      }

      if (offsetQueryParam != null) {
        offset = int.parse(offsetQueryParam);
      } else {
        offset = 0;
      }

      var notesList =
          await dependencies.noteModule.noteService.list(limit, offset);

      return Response.ok(jsonEncode({'success': true, 'data': notesList}));
    });

    router.get('/<id>', (Request req, String id) async {
      var note = await dependencies.noteModule.noteService.get(id);

      return Response.ok(jsonEncode({'success': true, 'data': note}));
    });

    router.post('/', (Request req) async {
      var body = await req.body.asJson;

      await dependencies.noteModule.noteService.create(userId: body['userId'], text: body['text']);

      return Response.ok(jsonEncode({ 'success': true}));
    });

    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}
