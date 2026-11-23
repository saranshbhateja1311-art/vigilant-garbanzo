JEE X OS 2.0 — Supabase cloud sync + Android APK

Cloud sync:
- Supabase Auth sign-in/sign-up.
- Local-first persistence, then atomic snapshot upsert to jeex_cloud_state.
- Realtime updates for the signed-in user.
- Per-user RLS.
- No service-role key in the client.

Android:
- GitHub Actions workflow: .github/workflows/build-apk.yml
- Workflow artifact: JEE-X-OS-debug-apk
- Local build: run android-build.bat with Node.js, Java and Android SDK installed.
