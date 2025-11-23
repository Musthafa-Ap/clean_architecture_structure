import 'package:dio/dio.dart';
import 'package:sample/features/notes/data/models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> fetchNotes();
  Future<NoteModel> fetchNote(int id);
  Future<NoteModel> createNote(NoteModel note);
  Future<NoteModel> updateNote(NoteModel note);
  Future<void> deleteNote(int id);
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final Dio dio;
  NoteRemoteDataSourceImpl(this.dio);

  @override
  Future<List<NoteModel>> fetchNotes() async {
    final resp = await dio.get('/notes');
    final data = resp.data as List<dynamic>;
    return data.map((e) => NoteModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<NoteModel> fetchNote(int id) async {
    final resp = await dio.get('/notes/$id');
    return NoteModel.fromJson(Map<String, dynamic>.from(resp.data));
  }

  @override
  Future<NoteModel> createNote(NoteModel note) async {
    final resp = await dio.post('/notes', data: note.toJson());
    return NoteModel.fromJson(Map<String, dynamic>.from(resp.data));
  }

  @override
  Future<NoteModel> updateNote(NoteModel note) async {
    final resp = await dio.put('/notes/${note.id}', data: note.toJson());
    return NoteModel.fromJson(Map<String, dynamic>.from(resp.data));
  }

  @override
  Future<void> deleteNote(int id) async {
    await dio.delete('/notes/$id');
  }
}
