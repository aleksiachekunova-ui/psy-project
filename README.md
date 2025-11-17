# psy-project  
**Fill Your Cup** — a mobile, AI-supported behavioral activation intervention for young adults experiencing major depressive disorder (MDD).

## Overview  
Fill Your Cup is an intervention-focused mobile application designed to help young adults manage and recover from major depressive disorder. The app translates evidence-based behavioral activation principles into small, achievable daily actions that feel manageable even on low-energy days. The intervention is built to reduce anhedonia, increase routine stability, and gently reintroduce rewarding behaviors that improve functioning over time.

Fill Your Cup will be available on both iOS and Android platforms to ensure broad accessibility among young adults.

## Onboarding and Personalization  
During sign-up, users complete a brief onboarding questionnaire assessing:  
- mood patterns  
- lifestyle habits  
- sources of stress and recovery  
- personal goals  
- preferred pace and level of functioning  

These inputs allow the system to generate individualized task recommendations that match the user’s daily capacity.

## User Experience and Behavioral Logic  
The experience is designed to be simple, “sticky,” and emotionally supportive. The core visual element is a cup that fills gradually as users complete micro-tasks. This metaphor reduces overwhelm and encourages incremental progress.

Daily tasks include low-barrier, achievable behaviors such as:  
- taking a short walk  
- sending a text to a friend  
- doing a two-minute breathing exercise  
- making the bed  
- stepping outdoors for a few minutes  

The app breaks goals into bite-sized steps to reduce avoidance and support behavioral activation. The behavioral engine focuses on closing the gap between *knowing* what helps and *doing* what helps.

### Tone and Guidance  
Notifications use a gentle, nonjudgmental tone. Missed days are treated flexibly: users are invited to reschedule rather than being penalized. This mirrors the communication style of effective mental health interventions.

Example prompts:  
- “Choose one tiny thing to fill your cup this morning.”  
- “You mentioned time outdoors helps. Want to step out for a few minutes?”

## Motivation, Reinforcement, and Engagement  
To enhance ongoing engagement, users earn:  
- badges (e.g., **First Sip** for completing three daily tasks)  
- streak awards (e.g., **Steady Stream** for maintaining a three-day streak)  
- weekly “cup-filling” summaries that visualize connections between behavior and mood  

Weekly goals bundle micro-tasks into simple behavior plans such as:  
- “Move your body three times this week”  
- “Reach out to two people”  
- “Try one calming practice”

Optional social features (sharing milestones or joining peer-support groups) are available on an opt-in basis to preserve privacy while offering community support where desired.

## Visual and Interaction Design  
The interface uses:  
- calming, unobtrusive color palettes  
- minimal visual clutter  
- clear, intuitive iconography  
- fast, frictionless navigation  

This ensures usability even during periods of low motivation and cognitive strain.

## Data Collection and Personalization Model  
Fill Your Cup integrates both self-report and passive behavioral data to model patterns relevant to MDD.

### Active Data (Self-Report)  
Daily ecological momentary assessments (EMAs) capture:  
- mood  
- energy level  
- activity engagement  
- satisfaction with “cup-filling” tasks  
- perceived stress  
- social interaction quality  

### Passive Data (Digital Phenotyping)  
With user consent, the app collects:  
- movement data (accelerometer, step count)  
- sleep patterns (from phone or wearables)  
- screen-use indicators  
- heart-rate variability (optional wearable integration)  
- physical activity levels  

For users opting into clinical partnerships, the app can integrate clinician-provided wearable sensor data via secure medical APIs.

### Modeling Approach  
The system detects:  
- deviations from baseline routines  
- changes in reward-seeking behavior  
- patterns associated with mood fluctuations  
- early indicators of disengagement  

Integrating behavioral activation logic with sensor-informed personalization enables the app to deliver timely, context-aware nudges.

## Evidence Base  
Similar digital interventions combining app-based cognitive-behavioral therapy and sensor-driven personalization have demonstrated medium-to-large effect sizes (r ≈ .6–.8) in randomized controlled trials (Fatouros et al., 2025). Fill Your Cup builds on this literature by treating depression as a disorder of **reward** and **rhythm**, using data to identify when these systems drift and gently nudging users back toward regular, rewarding behaviors.

## Core Intervention Philosophy  
Fill Your Cup aims to feel like a supportive companion rather than a clinical tool. It prioritizes:  
- emotional safety  
- small wins  
- flexible progress  
- personalization  
- sustained engagement  

By combining behavioral activation, empathic design, and digital phenotyping, the app seeks to improve functioning in young adults with major depressive disorder.

## Technology Stack  
- iOS (SwiftUI)  
- Android (Kotlin, Jetpack Compose planned)  
- Python backend  
- FastAPI  
- Behavioral modeling and digital phenotyping pipelines  
- Optional integrations with wearable APIs (e.g., sleep, HRV, activity)  

## Status  
The intervention is in active development, with ongoing work on:  
- strengthening personalization models  
- refining micro-task recommendation logic  
- designing EMA sequences  
- optimizing the reward and streak systems  
- expanding clinical research partnerships  

## Collaboration  
We welcome collaboration in:  
- digital mental health intervention research  
- affective computing  
- clinical psychology  
- computational psychiatry  
- digital phenotyping  
- human–AI interaction  

For academic or clinical partnership inquiries, please reach out.

