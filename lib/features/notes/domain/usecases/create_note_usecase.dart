import 'package:dartz/dartz.dart';
import 'package:sample/core/failures.dart';
import 'package:sample/features/notes/domain/entities/note_entity.dart';
import 'package:sample/features/notes/domain/repositories/note_repository.dart';

class CreateNoteUsecase {
  final NoteRepository repository;
  CreateNoteUsecase(this.repository);

  Future<Either<Failure, NoteEntity>> call(NoteEntity note) async {
    return await repository.createNote(note);
  }
}
