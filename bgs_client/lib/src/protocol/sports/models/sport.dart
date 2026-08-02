/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// The sport a league, event, team, or match is played in.
///
/// The full long-term list is tracked in SPORTS_ROADMAP.md at the repo
/// root. Not every value here has scoring/standings logic behind it yet --
/// see BUILD_PLAN.md for which sports are actually live at a given phase.
enum Sport implements _i1.SerializableModel {
  basketball,
  softball,
  baseball,
  soccer,
  flagFootball,
  football,
  ultimate,
  lacrosse,
  fieldHockey,
  iceHockey,
  floorHockey,
  dekHockey,
  broomball,
  bubbleSoccer,
  volleyballIndoor,
  volleyballSand,
  volleyballGrass,
  kickball,
  dodgeball,
  cornhole,
  bocce,
  bowling,
  wiffleBall,
  skeeball,
  spikeball,
  tBall,
  pickleball,
  tennis,
  golf,
  darts,
  curling;

  static Sport fromJson(String name) {
    switch (name) {
      case 'basketball':
        return Sport.basketball;
      case 'softball':
        return Sport.softball;
      case 'baseball':
        return Sport.baseball;
      case 'soccer':
        return Sport.soccer;
      case 'flagFootball':
        return Sport.flagFootball;
      case 'football':
        return Sport.football;
      case 'ultimate':
        return Sport.ultimate;
      case 'lacrosse':
        return Sport.lacrosse;
      case 'fieldHockey':
        return Sport.fieldHockey;
      case 'iceHockey':
        return Sport.iceHockey;
      case 'floorHockey':
        return Sport.floorHockey;
      case 'dekHockey':
        return Sport.dekHockey;
      case 'broomball':
        return Sport.broomball;
      case 'bubbleSoccer':
        return Sport.bubbleSoccer;
      case 'volleyballIndoor':
        return Sport.volleyballIndoor;
      case 'volleyballSand':
        return Sport.volleyballSand;
      case 'volleyballGrass':
        return Sport.volleyballGrass;
      case 'kickball':
        return Sport.kickball;
      case 'dodgeball':
        return Sport.dodgeball;
      case 'cornhole':
        return Sport.cornhole;
      case 'bocce':
        return Sport.bocce;
      case 'bowling':
        return Sport.bowling;
      case 'wiffleBall':
        return Sport.wiffleBall;
      case 'skeeball':
        return Sport.skeeball;
      case 'spikeball':
        return Sport.spikeball;
      case 'tBall':
        return Sport.tBall;
      case 'pickleball':
        return Sport.pickleball;
      case 'tennis':
        return Sport.tennis;
      case 'golf':
        return Sport.golf;
      case 'darts':
        return Sport.darts;
      case 'curling':
        return Sport.curling;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "Sport"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
