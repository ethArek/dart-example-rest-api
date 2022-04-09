import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'NotesController.dart';

class MainController {
  NotesController notesController;

  MainController(this.notesController);

  Handler get handler {
    final router = Router();

    router.mount('/notes', notesController.router);

    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}
