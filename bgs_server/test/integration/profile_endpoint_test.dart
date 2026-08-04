import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Profile endpoint', (sessionBuilder, endpoints) {
    Future<TestSessionBuilder> authedSessionFor(
      TestSessionBuilder builder,
    ) async {
      final authUser = await const AuthUsers().create(builder.build());
      return builder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          authUser.id.toString(),
          {},
        ),
      );
    }

    /// Creates an authed session for a brand-new user with a profile
    /// already attached, mirroring what the email sign-up flow does for a
    /// real user.
    Future<TestSessionBuilder> authedProfileSessionFor(
      TestSessionBuilder builder, {
      String? userName,
      String? fullName,
      String? email,
    }) async {
      final session = builder.build();
      final authUser = await const AuthUsers().create(session);
      await const UserProfiles().createUserProfile(
        session,
        authUser.id,
        UserProfileData(
          userName: userName,
          fullName: fullName,
          email: email ?? '${authUser.id}@example.com',
        ),
      );
      return builder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          authUser.id.toString(),
          {},
        ),
      );
    }

    test(
      'when a user with a profile calls get then it returns their own '
      'profile',
      () async {
        final playerSession = await authedProfileSessionFor(
          sessionBuilder,
          userName: 'jsmith',
          fullName: 'Jordan Smith',
        );

        final profile = await endpoints.profile.get(playerSession);

        expect(profile.userName, 'jsmith');
        expect(profile.fullName, 'Jordan Smith');
      },
    );

    test(
      'when a user changes their username then get reflects the change',
      () async {
        final playerSession = await authedProfileSessionFor(
          sessionBuilder,
          userName: 'original-name',
        );

        await endpoints.profile.changeUserName(playerSession, 'new-name');
        final profile = await endpoints.profile.get(playerSession);

        expect(profile.userName, 'new-name');
      },
    );

    test(
      'when a user changes their full name then get reflects the change',
      () async {
        final playerSession = await authedProfileSessionFor(
          sessionBuilder,
          fullName: 'Original Name',
        );

        await endpoints.profile.changeFullName(playerSession, 'Updated Name');
        final profile = await endpoints.profile.get(playerSession);

        expect(profile.fullName, 'Updated Name');
      },
    );

    test(
      'when a user with no profile calls get then it throws',
      () async {
        final bareSession = await authedSessionFor(sessionBuilder);

        expect(
          () => endpoints.profile.get(bareSession),
          throwsA(isA<UserProfileNotFoundException>()),
        );
      },
    );
  });
}
