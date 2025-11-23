import 'package:dartz/dartz.dart';
import 'package:sample/core/failures.dart';
import 'package:sample/features/notes/domain/entities/note_entity.dart';
import 'package:sample/features/notes/domain/repositories/note_repository.dart';

class GetNoteUsecase {
  final NoteRepository repository;
  GetNoteUsecase(this.repository);

  Future<Either<Failure, NoteEntity>> call(int id) async {
    return await repository.getNote(id);
  }
}
