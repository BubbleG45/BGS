import 'dart:io';

import 'package:bgs_client/bgs_client.dart';

/// Server-side Serverpod client for anonymous, read-only access to
/// [PublicEndpoint] -- the one backend endpoint with `requireLogin => false`
/// (see BUILD_PLAN.md §7). Only ever imported from non-`@client` files: it
/// depends on `dart:io` and must never be pulled into the browser bundle.
final bgsClient = Client(
  Platform.environment['BGS_API_URL'] ?? 'http://localhost:18080/',
);
