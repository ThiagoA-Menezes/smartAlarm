# smartAlarm ⏰

> A location-aware alarm clock that knows when *not* to wake you up.

`smartAlarm` is a mobile alarm app that respects **public holidays** and your **work schedule**. If today is a holiday in your city or a day off in your shift, the alarm stays silent — no more manually disabling alarms every Friday night.

🚧 **Status:** in active development (Flutter · Android + iOS).

---

## Why

Most alarm apps are dumb about context: they ring on holidays, on your days off, and force you to toggle them manually every week. `smartAlarm` adds a small "brain" between you and the alarm — it decides whether an alarm *should* ring based on the day of the week, your work schedule, and whether today is a holiday where you live.

## Features

- 📅 **Holiday-aware** — won't ring on national/state holidays for your location (Brazil first, via public holiday data).
- 🔁 **Work-schedule aware** — supports fixed weeks (e.g. Mon–Fri) and rotating shifts (5x2, 6x1, 4x2). Flags for *"do you work weekends?"* and *"do you work on holidays?"*.
- 📍 **Location-based** — detects your state/municipality (with manual override for privacy and travel).
- ⏰ **Reliable system-level alarms** — fires with the app closed, screen off, even in silent/Focus mode.
- 🔧 Standard alarm controls — time, repeat days, custom sound, volume, vibration, snooze.

## Tech stack

| Layer | Choice |
|---|---|
| Framework | Flutter (single codebase, Android + iOS) |
| Alarm engine | `alarm` package — `AlarmManager`/foreground service (Android) + AlarmKit (iOS 26+) |
| Local storage | drift (SQLite) |
| State | Riverpod |
| Location | geolocator + geocoding |
| Holidays | BrasilAPI (national), pluggable for state/municipal sources |

## Platform requirements

- **Android:** requires the *exact alarm* permission (`SCHEDULE_EXACT_ALARM`), requested at runtime.
- **iOS:** requires **iOS 26+** (AlarmKit) for reliable alarms that override silent/Focus mode.

## Getting started

> The app is still being built; these steps describe the intended dev setup.

```bash
git clone https://github.com/ThiagoA-Menezes/smartAlarm.git
cd smartAlarm
flutter pub get
flutter run
```

iOS builds require macOS + Xcode and a physical device running iOS 26.

## Project structure

```
lib/
├── core/        # permissions, date helpers, constants
├── data/        # drift DB, holiday & location repositories
├── domain/      # pure models + business logic (shouldRing rule)
├── services/    # alarm engine wrapper, rescheduler
├── features/    # screens (one folder per feature) + Riverpod providers
└── ui/          # shared widgets and theme
```

## Roadmap

Development is organized into small, ordered sprints (S0–S13): bootstrap & quality gates → domain models → core ring-decision logic → persistence → holidays → location → alarm engine → rescheduler → UI → polish → release.

## License

TBD.

## Author

**Thiago Menezes** — Data Intelligence Specialist @ IBM Brazil
🌐 [thiagoa-menezes.github.io](https://thiagoa-menezes.github.io/) · São Paulo, Brazil
