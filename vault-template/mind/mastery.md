# Mastery

Per-concept state, maintained by the session. States:
`unprobed` → `probed-pass` (skipped — evidence it's already held) /
`probed-miss` → `taught` → `locked` (passed a variant after teaching).

A row only reaches `locked` through a correct *variant* answer — never by
having been taught. `probed-pass` rows are not re-probed within 7 days.

## <course> — <unit>

| Block | State | Last touched | Notes |
|---|---|---|---|
| <concept block> | unprobed | — | |
