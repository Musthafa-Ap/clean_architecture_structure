import 'package:dartz/dartz.dart';
import 'package:sample/core/failures.dart';
import 'package:sample/features/notes/domain/repositories/note_repository.dart';

class DeleteNoteUsecase {
  final NoteRepository repository;
  DeleteNoteUsecase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteNote(id);
  }
}
