import 'package:equatable/equatable.dart';
import 'package:sample/features/notes/domain/entities/note_entity.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object?> get props => [];
}

class NotesInitial extends NoteState {
  const NotesInitial();
}

class NotesLoading extends NoteState {
  const NotesLoading();
}

class NotesLoaded extends NoteState {
  final List<NoteEntity> notes;
  const NotesLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NotesError extends NoteState {
  final String message;
  const NotesError(this.message);

  @override
  List<Object?> get props => [message];
}
