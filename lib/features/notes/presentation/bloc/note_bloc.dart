import 'package:bloc/bloc.dart';
import 'package:sample/features/notes/domain/usecases/create_note_usecase.dart';
import 'package:sample/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:sample/features/notes/domain/usecases/get_note_usecase.dart';
import 'package:sample/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:sample/features/notes/domain/usecases/update_note_usecase.dart';
// imports cleaned: failures and direct entity import removed
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotesUsecase getNotes;
  final GetNoteUsecase getNote;
  final CreateNoteUsecase createNote;
  final UpdateNoteUsecase updateNote;
  final DeleteNoteUsecase deleteNote;

  NoteBloc({required this.getNotes, required this.getNote, required this.createNote, required this.updateNote, required this.deleteNote}) : super(NotesInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(NotesLoading());
    final res = await getNotes();
    res.fold((f) => emit(NotesError(f.message)), (notes) => emit(NotesLoaded(notes)));
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    emit(NotesLoading());
    final res = await createNote(event.note);
    res.fold((f) => emit(NotesError(f.message)), (n) async {
      final updated = await getNotes();
      updated.fold((f) => emit(NotesError(f.message)), (notes) => emit(NotesLoaded(notes)));
    });
  }

  Future<void> _onUpdateNote(UpdateNoteEvent event, Emitter<NoteState> emit) async {
    emit(NotesLoading());
    final res = await updateNote(event.note);
    res.fold((f) => emit(NotesError(f.message)), (n) async {
      final updated = await getNotes();
      updated.fold((f) => emit(NotesError(f.message)), (notes) => emit(NotesLoaded(notes)));
    });
  }

  Future<void> _onDeleteNote(DeleteNoteEvent event, Emitter<NoteState> emit) async {
    emit(NotesLoading());
    final res = await deleteNote(event.id);
    res.fold((f) => emit(NotesError(f.message)), (_) async {
      final updated = await getNotes();
      updated.fold((f) => emit(NotesError(f.message)), (notes) => emit(NotesLoaded(notes)));
    });
  }
}
