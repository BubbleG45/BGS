import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

/// By extending [UserProfileEditBaseEndpoint], the profile read/edit
/// endpoints (`get`, `changeUserName`, `changeFullName`, `setUserImage`,
/// `removeUserImage`) are made available on the server -- same pattern as
/// `EmailIdpEndpoint` extending `EmailIdpBaseEndpoint`. Always self-scoped
/// to the calling user; there's no "view another user's profile" surface
/// yet (later enhancement, once e.g. team rosters need to show names).
///
/// `setUserImage`/`removeUserImage` work but aren't exercised by BGS's own
/// tests yet -- no file storage backend is configured for local dev, so
/// they'd fail at runtime here until that's set up.
class ProfileEndpoint extends UserProfileEditBaseEndpoint {}
