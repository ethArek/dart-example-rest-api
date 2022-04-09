// import 'dart:async' show Future;
import 'dart:convert';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import '../modules/note/services/NoteService.dart';

class NotesController {
  NoteService noteService;

  NotesController(this.noteService);

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

      var notesList = await noteService.list(limit, offset);

      return Response.ok(
          jsonEncode({'success': true, 'data': jsonEncode(notesList)}));
    });

    router.get('/<id>', (Request req, String id) async {
      var note = await noteService.get(id);

      return Response.ok(
          jsonEncode({'success': true, 'data': jsonEncode(note)}));
    });

    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}
