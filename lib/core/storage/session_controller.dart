import 'package:chauffeur_hub/core/storage/session_store.dart';
import 'package:flutter/foundation.dart';

// Because it extends [ChangeNotifier], components across the app (like GoRouter)
// can listen to changes via notifyListeners().
// A SessionStore built with ChangeNotifier manages user authentication states, tokens, and profile data across your application
final class SessionController extends ChangeNotifier {
  SessionController(this._store);

  final SessionStore _store;
  String? _token;
  bool _isReady = false;

  bool get isReady => _isReady;
  bool get isAuthenticated => _token?.isNotEmpty ?? false;
  String? get token => _token;

  // Called typically during app startup to restore the session state from persistent storage.
  Future<void> restore() async {
    _token = await _store.readToken();
    // after load complete for preferences then set isReady to true that can go to complete app flow
    _isReady = true;
    notifyListeners();
  }

  Future<void> establish({
    required String token,
    required String accountCode,
    required String driverName,
  }) async {
    await _store.saveSession(
      token: token,
      accountCode: accountCode,
      driverName: driverName,
    );
    _token = token;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _store.clearSession();
    _token = null;
    notifyListeners();
  }
}


/// The [SessionController] is the central authentication state manager for the app.
///
/// It acts as the single source of truth for whether a driver is logged in or out,
/// holding session credentials in memory while syncing them with persistent
/// storage (`SessionStore`).
///
/// ### Key Responsibilities
///
/// 1. **Reactive Auth State ([ChangeNotifier])**
///    Extends [ChangeNotifier] so components across the app (such as `GoRouter`)
///    can react to changes via `notifyListeners()`.
///    * `isReady`: `true` after the initial session check completes on app launch.
///    * `isAuthenticated`: `true` if a non-empty JWT token exists in memory.
///    * `token`: The active user's JWT Bearer token.
///
/// 2. **Core Methods**
///    * `restore()`: (Called on Splash screen) Reads the saved JWT token from
///      encrypted storage (`FlutterSecureStorage`). Sets `isReady = true` and
///      notifies listeners.
///    * `establish({token, accountCode, driverName})`: (Called on Login) Saves
///      the new session to encrypted storage and shared preferences, updates
///      `_token` in memory, and notifies listeners (triggering auto-navigation
///      to `/home`).
///    * `signOut()`: (Called on Logout or a 401 Unauthorized error) Clears all
///      session keys from storage and sets `_token = null`. Notifying listeners
///      automatically redirects the user back to `/login`.
///
/// ### How It Integrates Across the App
///
/// 1. **Routing (`GoRouter` Navigation Guard)**:
///    Supplied as `refreshListenable: session` in `GoRouter`. Whenever [signOut]
///    or [establish] triggers a notification, `GoRouter` re-evaluates if the
///    driver is authorized to view the requested page.
///
/// 2. **Network Interceptor (`DioFactory`)**:
///    * Automatically attaches `Authorization: Bearer $token` to outgoing API requests.
///    * If an API endpoint returns `401 Unauthorized` (expired session), the
///      network interceptor calls `session.signOut()` to gracefully return the
///      user to the login screen.

