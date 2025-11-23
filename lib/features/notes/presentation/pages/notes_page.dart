import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/injection.dart';
import 'package:sample/features/notes/presentation/bloc/note_bloc.dart';
import 'package:sample/features/notes/presentation/bloc/note_event.dart';
import 'package:sample/features/notes/presentation/bloc/note_state.dart';
import 'package:sample/features/notes/domain/entities/note_entity.dart';
import 'package:sample/features/notes/presentation/pages/note_form_page.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc(
        getNotes: sl(),
        getNote: sl(),
        createNote: sl(),
        updateNote: sl(),
        deleteNote: sl(),
      )..add(LoadNotes()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Notes')),
        body: const _NotesView(),
        floatingActionButton: Builder(builder: (ctx) {
          return FloatingActionButton(
            onPressed: () async {
              final res = await Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => const NoteFormPage()));
              if (res == true) {
                ctx.read<NoteBloc>().add(LoadNotes());
              }
            },
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}

class _NotesView extends StatelessWidget {
  const _NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NotesLoading || state is NotesInitial) return const Center(child: CircularProgressIndicator());
      if (state is NotesError) return Center(child: Text('Error: ${state.message}'));
      if (state is NotesLoaded) {
        final notes = state.notes;
        if (notes.isEmpty) return const Center(child: Text('No notes'));
        return ListView.separated(
          itemCount: notes.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final note = notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
              onTap: () async {
                final updated = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => NoteFormPage(note: note)));
                if (updated == true) {
                  context.read<NoteBloc>().add(LoadNotes());
                }
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<NoteBloc>().add(DeleteNoteEvent(note.id));
                },
              ),
            );
          },
        );
      }
      return const SizedBox.shrink();
    });
  }
}
