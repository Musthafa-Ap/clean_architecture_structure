import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'core/network/api_client.dart';
import 'features/notes/data/datasources/note_remote_data_source.dart';
import 'features/notes/data/repositories/note_repository_impl.dart';
import 'features/notes/domain/usecases/create_note_usecase.dart';
import 'features/notes/domain/usecases/delete_note_usecase.dart';
import 'features/notes/domain/usecases/get_note_usecase.dart';
import 'features/notes/domain/usecases/get_notes_usecase.dart';
import 'features/notes/domain/usecases/update_note_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio client (centralized)
  final dioClient = DioClient();
  sl.registerLazySingleton<DioClient>(() => dioClient);
  sl.registerLazySingleton<Dio>(() => sl<DioClient>().client);
  // Api client
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()));

  // Data sources
  sl.registerLazySingleton<NoteRemoteDataSource>(() => NoteRemoteDataSourceImpl(sl<ApiClient>()));

  // Repositories
  sl.registerLazySingleton(() => NoteRepositoryImpl(sl<NoteRemoteDataSource>()));

  // Use cases
  sl.registerLazySingleton(() => GetNotesUsecase(sl()));
  sl.registerLazySingleton(() => GetNoteUsecase(sl()));
  sl.registerLazySingleton(() => CreateNoteUsecase(sl()));
  sl.registerLazySingleton(() => UpdateNoteUsecase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUsecase(sl()));
}
