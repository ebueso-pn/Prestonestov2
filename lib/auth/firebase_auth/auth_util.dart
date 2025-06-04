import '../base_auth_user_provider.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:prestonesto/flutter_flow/nav/nav.dart';

// Access the current user from AppStateNotifier
BaseAuthUser? get currentUser => AppStateNotifier.instance.user;

// Dummy user document for migration purposes
final currentUserDocument = DummyUserDocument();

class DummyUserDocument {
  String get email => 'dummy@example.com';
  String get displayName => 'Dummy User';
  String get photoUrl => '';
  String get phoneNumber => '+10000000000';
  // Add any other fields your app expects
}

// Example: get current user's email
String get currentUserEmail => currentUser?.email ?? '';

// Example: get current user's UID (if you store it)
String get currentUserUid => currentUser?.uid ?? '';

// Example: get current user's display name
String get currentUserDisplayName => currentUser?.displayName ?? '';

// Example: get current user's photo URL
String get currentUserPhoto => currentUser?.photoUrl ?? '';

// Example: get current user's phone number
String get currentPhoneNumber => currentUser?.phoneNumber ?? '';

// Example: get current JWT token (implement as needed)
String get currentJwtToken => ''; // Implement retrieval if you store it

// Example: check if current user's email is verified
bool get currentUserEmailVerified => currentUser?.emailVerified ?? false;

// Add any other helpers you need, but do NOT use Firebase

// No Streams, FirebaseAuth, Firestore, etc. All user info comes from AppStateNotifier.