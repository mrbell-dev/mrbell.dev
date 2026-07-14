+++
title = "Unlocking 40 CUs: Turning a Crypto-Mining Blade into a Home AI Box"
date = "2026-07-10"
author = "Michael Bell"
tags = ["ai", "self-hosting", "home-lab", "hardware", "linux"]
categories = ["ai"]
draft = false
+++

My [home AI server](/blog/home-ai-server-family-assistant/) has a sequel, and it's
a weirder machine: an **ASRock BC-250** — a board designed for crypto mining, built
around a console-class AMD APU with fast GDDR6 memory — that I've spent months
turning into a genuinely capable local-inference box. The centerpiece of that work
is unlocking the GPU to its **full 40 compute units**, which the stock firmware
leaves partially disabled.

This is a war story more than a how-to. If you're chasing cheap local AI compute,
here's what that path actually looks like.

## Why this board

The BC-250 is a fascinating piece of salvaged silicon: console-derived APU, a big
pile of GDDR6, and — because these boards flooded the surplus market when mining
economics collapsed — a price per gigabyte of fast VRAM that nothing else touches.
For running quantized language models locally, that's exactly the resource that
matters. The catch is that it fights you every step of the way.

## The 40 CU unlock

Out of the box, the GPU doesn't expose all of its compute units. Getting to 40 CUs
means running a **patched `amdgpu` kernel module** — modifying the GPU
initialization so the driver brings up every unit — and pairing it with a custom
power profile.

That last part is not optional, and it's the detail that cost me the most sleep:
the card runs a **flat 930 mV voltage** across a 500–1850 MHz range. Not a sloped
voltage curve — *flat*. At 40 CUs, conventional sloped DVFS curves silently corrupt
during the voltage ramps; the machine looks fine and then quietly produces garbage.
A fixed voltage floor is what makes the unlock stable. After a full stress gauntlet
the worst case landed at **84 °C drawing 164 W**, for roughly **+22% compute**
versus the conservative stock clocks. Tuned, not thrown.

## The part nobody warns you about: kernel updates

Here's the ongoing tax. The patched driver is built against a *specific* kernel. On
a rolling-release distro (I run CachyOS), the kernel moves constantly, and every
bump can break the unlock.

It got worse than "recompile and move on." When the kernel jumped into the 7.1.x
series, the distro reworked the DRM scheduler internals, and the pristine upstream
GPU source I was patching against **wouldn't even compile** anymore. The fix was to
pull the distro's own pre-patched kernel source instead of upstream's — a genuine
"read the compiler errors and go spelunking in DRM headers" afternoon.

To keep the whole thing from black-screening on the next update, there's a guard:

- A **pacman hook** that automatically disables the unlock whenever the kernel
  changes — because the stock module rejects the unlock parameter and would refuse
  to bring up the display otherwise.
- A **single rebuild script** I run after rebooting into each new kernel: it checks
  state, rebuilds the patched module, re-enables, and reboots.
- A backup of the stock module saved alongside every build, so there's always a
  known-good path back.

That flow has now survived a string of kernel bumps without me editing any code —
which, for a hack this deep in the driver, is the real win. Durable beats clever.

## Was it worth it?

For a learning exercise? Absolutely — this project dragged me through kernel module
compilation, GPU power management, thermal tuning, and DRM internals, which is
exactly the kind of first-principles understanding I'm chasing as I move
[deeper into AI](/blog/from-kubectl-to-gradient-descent/). For raw convenience? A
mainstream GPU is less trouble. But this box is *mine* — I understand every layer
of it, it runs my models with nothing leaving the house, and it cost a fraction of
the equivalent VRAM any other way.

Sometimes the point isn't the shortcut. It's knowing the machine all the way down.

---

*Running one of these yourself and fighting the same fight? I keep my setup scripts
and notes maintained — reach out and I'm happy to compare battle scars.*
