+++
title = "Shipping a Friend's Card Game: Gravedigger"
date = "2026-04-04"
author = "Michael Bell"
tags = ["typescript", "react", "pwa", "games", "testing"]
categories = ["web"]
draft = false
+++

A friend of mine designed a card game. *Gravedigger* is a gothic single-player
solitaire game played with a standard 54-card deck: a cursed cemetery, the dead
keep rising, and you hold them back with iron, salt, fire, and silver. The design
— rules, enemies, world — is entirely
[@Pavornic](https://github.com/Pavornic)'s. My job was to make it playable on a
phone.

**▶ Play it: [mrbell-dev.github.io/gravedigger](https://mrbell-dev.github.io/gravedigger/)**

## Why a paper game wants a computer

The rules are simple to *play* and fiddly to *track*. Each turn you flip a card
from the graveyard, act, suffer, and refill your hand. Fall short on a smite and
the enemy *festers* — it gets stronger. Add splash damage, Lich Corruption, and
Iron's chain-flip, and suddenly there's real bookkeeping between you and the fun.

That bookkeeping is exactly what software is for. The digital version enforces
every rule so the player only makes the interesting decisions.

## The architecture: a pure engine, a dumb UI

The part I'm happiest with is the split:

- **`src/engine/`** is a pure, deterministic, framework-free TypeScript state
  machine. No React, no DOM, no timers, no randomness it doesn't own. Given a
  state and an action, it returns the next state.
- **`src/ui/`** is React, and it's deliberately dumb: it renders state and
  dispatches actions. Nothing else.

That one decision paid for everything downstream:

- **The rules engine is fully tested** with Vitest — festering, splash,
  corruption, all the tricky bookkeeping — without ever rendering a component.
- **Determinism gives you seed sharing for free.** Send a link (or a word) and a
  friend starts from the exact same graveyard.
- **Autosave and resume** are just serializing state.
- **Balance testing is a script, not a playtest weekend.** `npm run sim -- 4000`
  plays four thousand headless games and reports win rates, so tuning questions
  get answered with data.

## Mobile-first, offline forever

It ships as an installable PWA (vite-plugin-pwa): add it to your home screen,
play full-screen, and it works offline after the first load. Fonts are
self-hosted via Fontsource so even typography survives airplane mode. The whole
thing is a static site on GitHub Pages, deployed by GitHub Actions — no server,
no accounts, no tracking, which regular readers will recognize as a theme around
here.

## On credit and licensing

One deliberate choice: this repo is published for review and play, **not** under
an open-source license. The game design belongs to its creator, and the LICENSE
and README say so plainly. If you build someone else's game, put their name above
yours.

Stack: TypeScript · React · Vite · Vitest · vite-plugin-pwa. Grab a deck — or
don't, that's the point — and go dig some graves.
