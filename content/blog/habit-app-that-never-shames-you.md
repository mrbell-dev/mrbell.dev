+++
title = "Building a Habit App That Never Shames You"
date = "2026-07-11"
author = "Michael Bell"
tags = ["ai", "self-hosting", "product", "adhd", "pwa"]
categories = ["ai"]
draft = false
+++

Most habit trackers are built on a lie: that the way to make you consistent is to
punish you when you're not. Break a streak and watch the number reset to zero.
Miss a day and get a guilt-tinted notification. It works right up until the day you
slip — and then the shame does the opposite of what you needed, and you delete the
app.

I have ADHD. I've deleted a lot of those apps. So I built the one I actually
wanted: **[CYBER//FIT](https://cyberfit.dev)** — a cyberpunk self-improvement
tracker with a single non-negotiable rule. *It never shames you.*

## Forgiving by design

The whole product is organized around removing guilt as a mechanic:

- **Skip is not fail.** Missing a day doesn't zero your progress.
- **Streak shields** auto-absorb misses, so a bad week doesn't erase a good month.
- A reset is a **"reboot,"** never a "failure" — you come back to *"Good to see
  you, choom. Ready for a new gig?"*, not a pile of red X's.
- It **never shows you a count of missed days or notifications.** That number
  helps no one. It's not in the app.

Gamification is there — XP, levels, cosmetic cyberware unlocks — but it's
*scaffolding*, meant to get a habit started and then get out of the way as real
progress data takes over. Crucially, every reward is cosmetic. Nothing useful is
ever locked behind progress or payment.

## Off-grid by design

I'm a privacy-first, local-first engineer, and the app reflects it:

- After first load it works **100% offline, forever** — an installable PWA with a
  local database. There's no account. There's no server for your data to go to.
- **No analytics, no telemetry, no cookies, no tracking.** Backup is a local file
  you control.
- Notifications are strictly *nice-to-have*. If you opt in, the relay stores only
  an anonymous push token and the time slots you picked — it's blind to your
  schedule and your completions by design.

It's free forever, open source (MIT), and the whole thing runs on Cloudflare
Workers for about the cost of a domain.

## The AI sidecar: a coach you can text

The piece I'm most proud of as an engineer is private and personal:
**cyber-trainer**, an SMS coach that runs on my own hardware.

I text it in plain English — *"just finished the workout"* — and it logs the right
entry for me. The architecture is deliberately paranoid:

1. A text hits a **Twilio** number, forwarded through a **Cloudflare Tunnel** (no
   inbound ports open anywhere).
2. The request lands on a service running **on my Jetson**, co-located with a local
   **Qwen3-8B** model served by llama.cpp.
3. The model's *only* job is to turn one message into one strict JSON intent. It
   never touches storage and never touches the network.
4. My own code owns every read and write to the encrypted data vault, then texts
   back a confirmation.

That separation — the LLM interprets, my code acts — is what lets a small local
model run a real workflow safely. No cloud AI, no data leaving my house, the same
local-first ethic as the app it feeds.

## Why build it this way

Because the technology should serve the person, not the metrics dashboard. A habit
app's job is to make it a little easier to be who you're trying to be — on your
good days *and* the day after a bad one. Punishment-free isn't a soft feature; for
an ADHD brain it's the difference between a tool you keep and one you delete.

If any of that resonates, [try it](https://cyberfit.dev) — no signup, nothing to
lose, and it'll never make you feel bad for missing Tuesday.
