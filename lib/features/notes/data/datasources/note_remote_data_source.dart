import 'package:sample/core/network/api_client.dart';
import 'package:sample/features/notes/data/models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> fetchNotes();
  Future<NoteModel> fetchNote(int id);
  Future<NoteModel> createNote(NoteModel note);
  Future<NoteModel> updateNote(NoteModel note);
  Future<void> deleteNote(int id);
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final ApiClient apiClient;
  NoteRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<NoteModel>> fetchNotes() async {
    final resp = await apiClient.get('/notes');
    final data = resp as List<dynamic>;
    return data.map((e) => NoteModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<NoteModel> fetchNote(int id) async {
    final resp = await apiClient.get('/notes/$id');
    return NoteModel.fromJson(Map<String, dynamic>.from(resp));
  }

  @override
  Future<NoteModel> createNote(NoteModel note) async {
    final resp = await apiClient.post('/notes', data: note.toJson());
    return NoteModel.fromJson(Map<String, dynamic>.from(resp));
  }

  @override
  Future<NoteModel> updateNote(NoteModel note) async {
    final resp = await apiClient.put('/notes/${note.id}', data: note.toJson());
    return NoteModel.fromJson(Map<String, dynamic>.from(resp));
  }

  @override
  Future<void> deleteNote(int id) async {
    await apiClient.delete('/notes/$id');
  }
}
