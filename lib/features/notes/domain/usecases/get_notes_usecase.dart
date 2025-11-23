import 'package:dartz/dartz.dart';
import 'package:sample/core/failures.dart';
import 'package:sample/features/notes/domain/entities/note_entity.dart';
import 'package:sample/features/notes/domain/repositories/note_repository.dart';

class GetNotesUsecase {
  final NoteRepository repository;
  GetNotesUsecase(this.repository);

  Future<Either<Failure, List<NoteEntity>>> call() async {
    return await repository.getNotes();
  }
}
