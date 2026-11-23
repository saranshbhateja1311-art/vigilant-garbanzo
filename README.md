# JEE X OS 2.0 — JEE OS 5.0 architecture port

This release uses the uploaded **JEE OS 5.0** source as its architecture and application base. It is not the earlier standalone JEE X implementation.

## Curriculum
- Physics: 32 chapters / 55 lectures
- Chemistry: 34 chapters / 78 lectures
- Mathematics: 26 chapters / 59 lectures
- **Total: 92 chapters / 192 lectures**
- Chapter names, chapter order, lecture counts and PW chapter URLs are carried over from the supplied JEE X curriculum.

## Daily plan
- Exactly one next-incomplete Physics lecture, then one Chemistry lecture, then one Mathematics lecture per day.
- The schedule follows the chapter order supplied for each subject.
- If a subject finishes, the remaining subjects continue with one lecture each per day.
- Default start date: **23 November 2026**; editable in Settings.
- DPP tracking remains individual to each scheduled lecture.
- Independent practice remains date-specific for each subject.
- The six-cycle spaced revision system is retained.

## Application architecture
- `index.html`: original JEE OS UI shell and styling.
- `app.js`: original JEE OS application logic, views, planner, calendar, revision, backup, local-first state and cloud sync.
- `tracker.json`: source seed in the original JEE OS tracker format.
- `curriculum.json`: original JEE X curriculum source data.
- `server.js` + `start.bat`: local Windows server launcher.
- `SUPABASE-SCHEMA.sql`: isolated JEE X atomic cloud snapshot schema.
- `capacitor.config.json`, `android-build.bat`, and `.github/workflows/build-apk.yml`: Android wrapper and APK pipeline.

## Windows launch
1. Install Node.js 22 or newer.
2. Extract the ZIP to a writable folder.
3. Run `start.bat`.
4. The app opens at `http://127.0.0.1:3000`. Do not open `index.html` directly.

## Supabase cloud sync
- Uses the existing Supabase project configured in `app.js`.
- Sign in with the same email/password on desktop and Android.
- Local progress is saved immediately; cloud snapshots sync after changes and on reconnect.
- Realtime subscriptions propagate newer snapshots to active devices.
- Uses `public.jeex_cloud_state`, with RLS restricting each row to its authenticated owner.
- JEE X OS does not read or write the separate `jeeo_*` JEE OS tables.
- Only the Supabase publishable key is included in the client; no service-role key is present.

## Android APK
- Push the folder contents to a GitHub repository.
- Open **Actions → Build JEE X OS Android APK → Run workflow**.
- Download the artifact **JEE-X-OS-debug-apk**.
- This ZIP contains the build workflow, not a precompiled APK.
