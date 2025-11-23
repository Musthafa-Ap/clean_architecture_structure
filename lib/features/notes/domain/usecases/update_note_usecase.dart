import 'package:dartz/dartz.dart';
import 'package:sample/core/failures.dart';
import 'package:sample/features/notes/domain/entities/note_entity.dart';
import 'package:sample/features/notes/domain/repositories/note_repository.dart';

class UpdateNoteUsecase {
  final NoteRepository repository;
  UpdateNoteUsecase(this.repository);

  Future<Either<Failure, NoteEntity>> call(NoteEntity note) async {
    return await repository.updateNote(note);
  }
}
