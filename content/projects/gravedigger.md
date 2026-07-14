+++
title = "Gravedigger"
date = "2026-04-04"
description = "Gothic solitaire card game as an offline-first PWA — pure deterministic rules engine, React UI, headless balance simulator."
demo = "https://mrbell-dev.github.io/gravedigger/"
github = "https://github.com/mrbell-dev/gravedigger"
tags = ["typescript", "react", "pwa", "vite", "games"]
categories = ["web"]
featured = true
+++

A digital implementation of *Gravedigger*, a gothic single-player solitaire game
played with a standard 54-card deck — designed by
[@Pavornic](https://github.com/Pavornic), built for the web by me. The rules
engine is a pure, deterministic, framework-free TypeScript state machine (fully
tested with Vitest); the React UI only renders state and dispatches actions. It
installs as a PWA, works offline after first load, supports seed-sharing links,
and ships with a headless simulator used to balance-test thousands of games at a
time.
