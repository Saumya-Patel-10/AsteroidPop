# 🚀 AsteroidsPlus

> A feature-rich, multi-level reimagining of the classic Asteroids arcade game, built with [Processing](https://processing.org/).

---

## 📖 Overview

**AsteroidsPlus** is a 2D arcade space shooter developed in Processing (Java mode). The player pilots a spaceship through three progressively challenging levels, destroying asteroids before they cause a collision. The game extends the original Asteroids formula with a power-up system, energy management, streak detection, sound effects, and a polished level-state machine.

---

## 🎮 Gameplay

### Objective
Destroy all asteroids in each level without losing all three lives. Clear all three levels to win.

### Controls

| Key | Action |
|---|---|
| `↑` Arrow | Thrust forward |
| `←` / `→` Arrows | Rotate ship |
| `Space` | Fire missile |

### Core Mechanics

- **Energy System** — The ship has an energy bar that depletes with each missile fired. Energy regenerates passively over time. Firing is disabled when energy drops below 20%.
- **Lives** — The player starts with **3 lives**, displayed as small blue squares near the ship. Colliding with an asteroid costs a life and deducts 1,000 points.
- **Asteroid Splitting** — Destroying a `BigAsteroid` spawns **3 SmallAsteroids** in its place.
- **Accuracy Tracker** — A live `Hits / Total Fired` counter is displayed on-screen throughout gameplay.
- **Streak System** — Landing **3 or more consecutive hits** without missing triggers a "Keep It Up!" banner as positive feedback.

---

## 🌌 Levels

| Level | Asteroids | Missile Speed | Power-Up Spawn Rate | Challenge |
|---|---|---|---|---|
| **Level 1** | 2 Big | 200 px/s | Every 10 s | Introductory |
| **Level 2** | 4 Big | 400 px/s | Every 10 s | Moderate |
| **Level 3** | 8 Big | 100 px/s | Every 20 s | Hard — slow missiles, dense field |

All levels use a state machine that transitions through: `Start → Level 1 → Level 2 → Level 3 → Win/Lose → Start`.

---

## ⚡ Power-Ups

Power-ups spawn at the center of the screen every N seconds and drift around the arena for up to 15 seconds before despawning. They can be collected by **touching** them with the ship or **shooting** them with a missile.

| Power-Up | Effect | Duration |
|---|---|---|
| 🛡️ **Shield** | Surrounds the ship with a red energy bubble that blocks asteroid collisions | 15 s |
| 🔱 **Triple Missile** | Each spacebar press fires 3 missiles in a spread pattern instead of 1 | 15 s |

Active power-ups display a color-coded timer bar near the ship (red = shield, green = triple missile).

---

## 🏆 Scoring

| Event | Points |
|---|---|
| Destroy any asteroid | +100 |
| Destroy a Big Asteroid (bonus) | +200 additional |
| Ship collides with asteroid | −1,000 (floor: 0) |

Score persists across all three levels and is displayed in the top-left corner during gameplay.

---

## 🗂️ Project Structure

```
AsteroidsPlus_Final/
│
├── AsteroidsPlus.pde        # Entry point — setup(), draw(), game loop, level state machine
├── GameLevel.pde            # Abstract base class for all game levels
├── AsteroidsGameLevel.pde   # Abstract level with shared asteroid/missile/collision logic
├── AsteroidsLevels.pde      # Concrete levels: AsteroidsLevel1, Level2, Level3 + Start/Win/Lose
│
├── GameObject.pde           # Base class for all sprites (ship, asteroids, missiles, etc.)
├── Ship.pde                 # Ship and Missile classes — movement, energy, power-up state
├── Asteroid.pde             # BigAsteroid and SmallAsteroid classes
├── PowerUps.pde             # Abstract PowerUp, ShieldPowerup, MissilePowerup
├── Explosion.pde            # Explosion animation sprites
├── Banners.pde              # On-screen banner overlays (e.g., "Keep It Up!", "Game Over")
├── Buttons.pde              # Clickable UI buttons (Start screen)
├── KeyboardController.pde   # Key state tracker for smooth multi-key input
├── SoundPlayer.pde          # Sound effect wrapper
│
└── data/                    # Assets
    ├── bg.jpg               # Space background (must be 1000×700)
    ├── ship.png / ships2.png
    ├── asteroids.png        # 3-frame sprite sheet for Big Asteroids
    ├── smallAsteroids.png   # 3-frame sprite sheet for Small Asteroids
    ├── missile.png
    ├── powerup.png
    ├── explosion.png
    ├── *.wav                # Sound effects (launch, explosion, power-up, game over)
    └── *.png                # Banner images (OhYea, KeepItUp, Winner, gameOver)
```

---

## 🛠️ Setup & Running

### Prerequisites

- [Processing 4.x](https://processing.org/download) — Download and install the IDE.
- **Sprites for Processing (S4P)** library — Install via Processing's Library Manager:
  - Open Processing → `Sketch` → `Import Library` → `Manage Libraries` → search **"Sprites"** → Install.

### Running the Game

1. Clone or download this repository.
2. Open `AsteroidsPlus_Final/AsteroidsPlus.pde` in the Processing IDE.
3. Press the **▶ Run** button (or `Ctrl+R` / `Cmd+R`).

> The game window opens at **1000 × 700 px**. Ensure the `data/` folder is intact alongside the `.pde` files.

---

## 🏗️ Architecture Notes

- **State Machine** — `nextLevelStateMachine()` in the main sketch transitions between level instances based on each level's `GameState` (Running / Finished / Lost).
- **Sprite Management** — All game objects extend `GameObject` (a wrapper around the S4P `Sprite` class). The S4P library handles rendering, collision detection (`checkCollision()`), and domain-boundary behavior (REBOUND).
- **Concurrency-Safe Collections** — `CopyOnWriteArrayList` is used for asteroid, missile, explosion, and power-up lists to safely iterate and remove during the same frame.
- **Streak Detection** — A continuous hit counter increments when consecutive hits are registered without an intervening miss; a "Keep It Up" explosion overlay fires at 3+ consecutive hits.

---

## 👤 Author

**Saumya Patel** — University of Texas at Dallas

---

## ⚠️ Academic Use Notice

This project was developed as a course assignment at UT Dallas. The source code is subject to the UT System's academic integrity policy. **Do not copy or redistribute for academic submissions.**
