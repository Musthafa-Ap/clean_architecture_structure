import 'package:dartz/dartz.dart';
import 'package:sample/core/failures.dart';
import 'package:sample/features/notes/domain/entities/note_entity.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<NoteEntity>>> getNotes();
  Future<Either<Failure, NoteEntity>> getNote(int id);
  Future<Either<Failure, NoteEntity>> createNote(NoteEntity note);
  Future<Either<Failure, NoteEntity>> updateNote(NoteEntity note);
  Future<Either<Failure, void>> deleteNote(int id);
}
