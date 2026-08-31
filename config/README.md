# G1 Runtime Configuration

The Flutter client reads non-secret runtime values from Dart defines. Copy
`dart_defines.example.json` to an ignored file such as
`dart_defines.development.json`, then replace the placeholders for an isolated
development or test Supabase project.

```powershell
flutter run -d emulator-5554 `
  --dart-define-from-file=config/dart_defines.development.json
```

## Variable inventory

| Variable | Required for connected prototype flows | Classification | Rule |
|---|---|---|---|
| `SUPABASE_URL` | Yes | Public project endpoint | Use only an isolated development/test project in G1 |
| `SUPABASE_PUBLISHABLE_KEY` | Yes | Public client credential | Preferred client key; it is not a `service_role` secret |
| `SUPABASE_ANON_KEY` | Compatibility fallback only | Public legacy client credential | Do not set when the publishable key is available |

Never place a `service_role` key, database password, signing key, access token,
refresh token, real child data, or production-only credential in this directory
or in Flutter build arguments. Running without the two required public values is
supported for the G1 foundation smoke path and shows a safe configuration notice.
