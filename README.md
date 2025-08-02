# 🧘‍♀️ Yoga Session Prototype App

A Flutter-based yoga session player that dynamically loads yoga flows from JSON — including pose images, audio instructions, and real-time captions with progress tracking. This was developed as part of an internship assignment.

---

## 📲 Features

- 🔄 Loads yoga session data from structured JSON
- 🧘 Displays pose image and guided voice + captions
- 🔊 Audio playback: intro, looped breath cycles, and outro
- ⏱ Progress bar indicating time per pose/segment
- ▶ Pause, resume, and auto transition to next segment
- 🎶 Optional background music support
- 🚪 Exit confirmation with styled dialog
- ✅ Uses Provider for clean state management
- 🔇 Added mute functionality

---

## 📁 Project Structure
assets/
├── poses.json # The session script and metadata
├── images/
│ ├── Base.png
│ ├── Cat.png
│ └── Cow.png
├── audio/
│ ├── cat_cow_intro.mp3
│ ├── cat_cow_loop.mp3
│ └── cat_cow_outro.mp3
lib/
├── models/ # Pose/session data model
├── providers/ # YogaSessionProvider
├── services/ # JSON parser (PoseLoader)
├── widgets/ # UI widgets like PoseDisplay, Controls, Dialog


## 🧩 How It Works

- The app loads `poses.json` at runtime and parses it into:
  - Metadata (title, category, loop count)
  - Audio references
  - Poses with start/end times and image references
- Each script segment is played with audio and caption text
- Progress bar updates every 200ms based on timer
- Audio and images are synced using the timing defined in JSON

---

## ⚠️ Note About Audio/Caption Sync

There may be **minor mismatches between the audio and captions** during playback.  
This is **not a bug in the app**, but due to how segment timings are defined in the `poses.json` file:

> ⏱ The app follows the `startSec` and `endSec` values strictly to schedule caption updates and segment transitions.

If you notice any out-of-sync issues:
- Please adjust the `startSec`/`endSec` values in the JSON to better align with the actual voice-over timing.
- Sync is fully controllable and customizable through the JSON script.
