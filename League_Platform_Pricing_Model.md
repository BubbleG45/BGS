# League Platform Pricing Model

*Working draft — for validation in Stage 1 operator interviews*

## 1. Overview

This model charges organizers a flat, upfront fee at the moment they create an event/tournament or activate a league, computed as a percentage of the team registration fee they've already set. There is no credit or token system, no prepaid balance, and no charge based on what actually happens after creation (turnout, weeks run, or games played). Payment processing is a separate, fully optional add-on.

## 2. Pricing Formula

Every event/tournament and every league requires a team registration fee to be entered at creation, regardless of how the organizer collects payment. The platform charge is computed directly from that fee:

| Product | Rate | Minimum | Covers |
|---|---|---|---|
| Event / tournament credit | 20% of team fee | $20 | One-off, single-day activity. Charged once per top-level division created. Pools, brackets, and playoffs within a division are included, not charged separately. |
| League credit | 30% of team fee | $50 | A full season, regardless of length or team count. Charged once at league activation, whether the season runs 1 week or 20. |

### Example pricing by team fee

| Team fee | Event / tournament (20%, min $20) | League (30%, min $50) |
|---|---|---|
| $50 | $20 | $50 |
| $100 | $20 | $50 |
| $150 | $30 | $50 |
| $200 | $40 | $60 |
| $300 | $60 | $90 |
| $450 | $90 | $135 |
| $600 | $120 | $180 |
| $700 | $140 | $210 |

*Note: floors do most of the separating between events and leagues at low team fees; above roughly $150–200/team, the percentages take over and the ratio settles at a steady 1.5x (league vs. event) for the same team fee.*

## 3. Fee Entry and Display

- A team fee is always required at creation — for every event, tournament, and league, regardless of how the organizer plans to collect payment.
- The fee is displayed publicly on the registration page. This is the model's integrity mechanism: an organizer who collects more than the number their own players saw published takes on a credibility problem with their own league. This is a reputational deterrent, not a technical verification — it makes underreporting visible and costly rather than impossible.
- Pricing is not sensitive to team count. Only the declared team fee drives the charge, so the price is fully known at the moment of creation, before registration opens.

## 4. Payment Processing (Optional Add-On)

- Organizers can collect payment however they like — cash, Venmo, in person, or through the platform's own processing. Nothing about the core event/league charge depends on this choice.
- When an organizer opts into platform processing, a thin markup applies on top of pass-through card cost: approximately 0.75–1% plus a small flat fee per transaction.
- This rate is kept well under LeagueApps' effective all-in processing rate (roughly 4–6% depending on source), so opting in never meaningfully erodes the platform's price advantage.

## 5. What's Deliberately Not in This Model

- **No credit or token system.** Every charge is a direct, computed dollar amount at the moment it's incurred — not a unit drawn from a purchased pack.
- **No prepaid wallet or balance.** Removed as a pricing mechanism; if reintroduced later, it should be a payment-convenience feature only, not tied to unit pricing.
- **No capacity-band fallback tier.** This existed only to handle leagues with an unverifiable, self-reported fee. Since a fee is now always required and always publicly displayed, there is nothing left for a fallback to cover.
- **No team-count sensitivity in pricing.** Considered and deliberately excluded — team count is an outcome of registration, not something known at the upfront moment of creation, and factoring it in would either require guessing (gameable) or pricing after the season starts (usage-based, which this model avoids).

## 6. Competitive Positioning

Comparison is against a LeagueApps-equivalent cost, estimated from publicly reported pricing: roughly $2–5 per athlete per season plus 2–3% payment processing, or an all-in effective rate cited by users at approximately 5% of transaction value. Figures below assume a realistic minimum league size of 6 teams, 10 players per team.

| Team fee | LeagueApps-equivalent (6 teams) | This model's league credit (30%) | Savings |
|---|---|---|---|
| $200 | ~$240 | $60 | 75% cheaper |
| $450 | ~$278 | $135 | 51% cheaper |
| $600 | ~$300 | $180 | 40% cheaper |
| $700 | ~$315 | $210 | 33% cheaper |

Even at the top of the fee range and a modest league size, this model stays comfortably under half of the LeagueApps-equivalent cost — and the gap holds even for organizers who additionally opt into the payment processing add-on, since that markup is set well below what LeagueApps effectively charges.

## 7. Open Questions for Validation

- Confirm actual team registration fees and current all-in platform costs directly with operators in Stage 1 interviews — the LeagueApps-equivalent figures here are estimates from public pricing sources, not confirmed invoices.
- Decide whether events and leagues should carry a larger premium at high team fees (currently converges toward a 1.5x ratio) or whether that convergence is acceptable.
- Validate the processing add-on rate (0.75–1% + flat fee) against real card-processing costs to confirm it remains profitable at low transaction volumes.
