import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/app_theme.dart';
import '../utils/format.dart';

/// Search field + sport chip row + location field + submit button --
/// replaces the bespoke filter row `search_screen.dart` used to hand-roll.
/// Purely a layout/input component: the caller owns the controllers and
/// decides what happens on submit.
class FilterBar extends StatelessWidget {
  final TextEditingController queryController;
  final String queryHint;
  final TextEditingController locationController;
  final Sport? selectedSport;
  final ValueChanged<Sport?> onSportChanged;
  final VoidCallback onSearch;

  const FilterBar({
    super.key,
    required this.queryController,
    required this.queryHint,
    required this.locationController,
    required this.selectedSport,
    required this.onSportChanged,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: queryController,
          decoration: InputDecoration(
            labelText: queryHint,
            prefixIcon: const Icon(Symbols.search),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => onSearch(),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: locationController,
          decoration: const InputDecoration(
            labelText: 'Location',
            prefixIcon: Icon(Symbols.location_on),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => onSearch(),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: ChoiceChip(
                  label: const Text('Any sport'),
                  selected: selectedSport == null,
                  onSelected: (_) => onSportChanged(null),
                ),
              ),
              for (final sport in Sport.values)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: ChoiceChip(
                    label: Text(formatEnumLabel(sport.name)),
                    selected: selectedSport == sport,
                    onSelected: (_) => onSportChanged(sport),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: onSearch, child: const Text('Search')),
        ),
      ],
    );
  }
}
