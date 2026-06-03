class CrashlyticsService {
  Future<void> crash() async {
    throw Exception('Demo Crash');
  }
}
