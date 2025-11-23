Recommended features-based folder structure

lib/src/
  core/                  # shared utilities, networking, constants, error handling
    network/
      dio_client.dart     # centralized DioClient class and interceptors
    failures.dart
  features/
    notes/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        bloc/
        pages/
        widgets/
    auth/
    profile/
    ...
  injection.dart          # GetIt registrations (compose feature modules)
  main.dart

Guidelines:
- Keep a single responsibility per file and prefer small, well-named classes.
- Each feature should be self-contained so it can be extracted to a package if needed.
- Share core utilities from `core/` only when they are truly common.
