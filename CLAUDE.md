# Lulubug's Garden pitch site

Private single-page pitch site Jacob is building for **Jil Hunter** (creator, Lulubug's Garden — kids show + parent education, launched April 30, 2026). Goal: open a low-pressure conversation, not ask for a job.

Full context (audit findings, brand assets, tone rules) lives in the `pitch-playbook` skill at `~/.claude/skills/pitch-playbook/SKILL.md`. Load it before writing copy.

## Team behind Lulubug's Garden
- **Jil Hunter** — creator/founder (Provo, Utah). Mother of 7. Origin story: personal mental health journey after 5th child.
- **Dr. Karen Manotas** — clinical advisor. Child/adolescent psychiatrist at Huntsman Mental Health Institute + University of Utah.
- **Brigham Taylor** — director. Former Disney studio exec. Produced *The Jungle Book*, *Christopher Robin*, *Lady and the Tramp*, *The One and Only Ivan*. Oversaw *Pirates of the Caribbean*, *Tron: Legacy*, *Chronicles of Narnia*.
- **6-person Executive Producer team**.
- Business: **Lulubug Enterprises LLC** (Utah).

## Their reality
- Kids show for ages 3-7. Mental health / social-emotional learning framing (Feelings Flower tool, character-driven).
- Multi-platform: YouTube (~1,290 subs), Facebook, Instagram, TikTok, Meta ads.
- No products, no digital content sold. Pre-monetization. Ad spend is audience building.
- Website: lulubugsgarden.com (Wix, published 4 times).

## Run it
Static site, no build step. Preview:
`python3 -m http.server 4321`, then open http://localhost:4321

## Files
- `index.html` — all pitch content, one page
- `audit.html` — full audit findings (35 items across 7 categories)
- `styles.css` — all styling (cream + pale mint + forest green + bright red palette, Fraunces display + Inter body)
- `main.js` — passwordless intro splash + scroll-reveal
- `images/` — supporting imagery

## Palette (all locked to Lulubug's actual brand)
- `#f9f5ea` — warm cream (main background)
- `#eaf1de` — pale mint (alternating section background)
- `#1e4a2e` — deep forest green (their heading/dark section color)
- `#e63946` — bright red (their CTA + primary accent)
- `#8cc63f` — grass green (secondary accent)
- `#f9c332` — Lulubug yellow (highlights)

## Hard copy rules
- Zero em dashes. Anywhere.
- No AI vocabulary (delve, robust, comprehensive, foster, etc.)
- Additive language only. Never "close the gap" or bash Wix / their setup.
- Personalize to the Lulubug's Garden team (not just Jil) — the pitch may be forwarded to Brigham/Dr. Karen/producers.
- Jacob is an operator with skin in the game (Aurean), not a fan.
- The Ask is deliberately low-pressure: "if any of this sounds right..." + no pushy CTA.
- Never mention personal contact info Jacob found via True People Search.
- Never invent metrics. Their YouTube numbers are estimates from launch date + observed views.

## Deploy
`git add . && git commit -m "..." && git push origin main` → GitHub Pages auto-deploys in 1-2 min. Repo: `github.com/jacogilliam-ai/lulubug-read`. Deploy only when Jacob asks.

## Pricing + scope (locked)
- **$4,500 flat, 2-week sprint (10 working days).**
- 50% upfront ($2,250), 50% within 15 days of delivery.
- Everything Wix-editor + integrations. No dev work.
- Full handoff docs. No lock-in.
