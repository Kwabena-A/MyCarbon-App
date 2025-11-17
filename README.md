# MyCarbon — Multi‑platform Carbon Footprint App

**Status:** ongoing

---

## One-line summary
Calculate, track and reduce personal CO2e with on‑device AI and authoritative datasets.

## Purpose
Deliver actionable, per‑activity carbon estimates and daily guidance so users reduce emissions.

## Goals
- Provide rapid, trustworthy carbon estimates and daily guidance.
- Train an AI predictor on real-world datasets (transport, energy, diet, consumption).
- Convert model outputs into per-activity CO2e and prioritized reduction recommendations.

## Why
Support UAE AI for Sustainability initiatives and produce measurable environmental impact through productized science.

## Science & sustainability
- Train supervised regressors on curated datasets (transport emission factors, regional energy mixes, LCA tables).
- Validate models against published benchmarks and version datasets.
- Surface per-feature contribution breakdowns for transparency and auditability.

## Problem addressed
Most people underestimate the carbon impact of everyday choices; MyCarbon quantifies impact and prescribes practical, personalized changes.

## Key features (final product)
- Quick estimate wizard: trip, home, food, purchases.  
- Continuous tracking dashboard: historic trends, alerts, progress goals.  
- AI-driven personalized reduction plan with predicted impact.  
- Scenario builder: compare behaviors and project footprint changes.  
- Exportable reports and locally relevant tips.

## Platforms
- UI: Flutter (single codebase for iOS, Android, Desktop, Web).  
- Native bindings: Swift/Kotlin/C++ modules for platform services where needed.

## Architecture (high level)
- UI: Flutter (Dart).  
- Native & core: C++ / platform modules for sensor, OS integrations and heavy compute.  
- Data layer: local encrypted store (default) + optional opt‑in sync backend.  
- ML: lightweight on‑device inference; server training pipeline for periodic model updates.

## Data & model
- Sources: transport emission factors, regional energy mixes, LCA tables, verified public datasets.  
- Model: supervised regressor mapping user behavior vectors → CO2e.  
- Training: curated, versioned datasets; holdout validation and comparison to benchmarks.  
- Explainability: per-feature contribution and confidence intervals exposed in UI.

## Privacy & security
- Local‑first by default; syncing only if user opts in.  
- Minimal personal data stored; PII encrypted at rest.  
- Full export and deletion of user data.  
- Audit logs for model updates and dataset versions.

## Roadmap (milestones)
1. Data collection & schema finalization — define dataset contracts, v1 schema, licensing.  
2. Baseline estimator + UI skeleton — implement estimator API, basic wizard and dashboard.  
3. On‑device inference — prune and convert model for mobile; integrate explainability.  

## Notes
- Version every dataset and model; keep reproducible training artifacts.  
- Prioritize explainability, minimal reversible data collection, and local‑first UX.
