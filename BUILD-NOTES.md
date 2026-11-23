# JEE X OS 2.0 build notes

- This release is ported from the uploaded `JEE OS 5.0` source archive.
- The UI and application architecture are based on the original `index.html` + `app.js` shell and `tracker.json` seed.
- Curriculum IDs are isolated as `JXP001` etc.; local storage uses `jee-x-os-v1`.
- Supabase state uses the isolated atomic snapshot table `public.jeex_cloud_state`.
- The old JEE OneShot tables were removed separately; the `jeeo_*` JEE OS tables are not read or modified by JEE X OS.
- Scheduler version 18 creates one Physics, one Chemistry and one Maths lecture per day in the supplied order.
- The start date defaults to 23 November 2026 and can be changed in Settings.
- The six-cycle revision system, DPP checkboxes, date-specific subject practice, calendar, analytics, focus tools, local-first save, JSON backup/restore, authentication, realtime sync, and Android workflow are retained from the JEE OS source.
