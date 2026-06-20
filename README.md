# Blotoon - Splatoon Clone in Godot

A 3D third-person (and eventual first-person) Splatoon clone built with Godot Engine.

## Project Structure

```
blotoon/
├── scenes/
│   ├── player/          # Player character scenes
│   ├── weapons/         # Weapon scenes
│   ├── levels/          # Map/arena scenes
│   ├── ui/              # UI scenes (HUD, menus)
│   ├── effects/         # Visual effects (particles, decals)
│   └── main.tscn        # Main scene
├── scripts/
│   ├── player/          # Player controller, camera
│   ├── weapons/         # Weapon logic
│   ├── game/            # Core game systems (painting, scoring)
│   └── ui/              # UI logic
├── assets/
│   ├── models/          # 3D models (.gltf, .glb, etc.)
│   ├── materials/       # Godot materials
│   ├── textures/        # Textures
│   └── sounds/          # Audio files
├── levels/              # Level data/config
└── docs/                # Documentation
```

## Getting Started

1. Open `project.godot` in Godot 4.x
2. Run the project (F5 or Play button)
3. Use WASD to move, mouse to look around, Space to sprint

## Features Roadmap

- [x] Project structure
- [ ] Player movement & camera system
- [ ] Ink painting system
- [ ] Weapon mechanics
- [ ] Map creation
- [ ] Game modes (Turf War, etc.)
- [ ] Multiplayer support
- [ ] First-person camera toggle
- [ ] UI/HUD

## Development Notes

### Input Map
- **WASD**: Move
- **Mouse**: Look around
- **Space**: Sprint
- **Left Click**: Fire weapon
- **R**: Reload

## Next Steps

1. Finalize player controller with collision shapes
2. Implement basic ink painting on terrain
3. Add weapon firing system
4. Create first arena level