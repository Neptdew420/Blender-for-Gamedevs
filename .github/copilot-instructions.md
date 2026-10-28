# Blender for Gamedevs Copilot Instructions

This codebase is **Blender for Gamedevs**, a creative suite combining:
1. **[Bforartists](https://www.bforartists.de/)**: The artist-centric Blender fork focused on intuitive UI ergonomics, colored iconography, customizable toolbars, tabbed toolshelves, and mouse-driven navigation.
2. **[UPBGE](https://upbge.org/)** (Uchronia Project Blender Game Engine): The modernized Blender Game Engine fork providing real-time Bullet physics, Logic Bricks, Python game components, viewport playtesting (`P`), and standalone game distribution (`blenderplayer.exe`).

---

## 1. Architecture Overview

### Core Subsystems

```
Blender-for-Gamedevs/
├── source/blender/          # Traditional DCC Application Layer (Modeling, Sculpting, Animation)
│   ├── makesdna/            # Data structure definitions (DNA) persisted in .blend files
│   ├── blenkernel/          # Core kernel functions operating on DNA data
│   ├── blenlib/             # Low-level utilities (memory, math, string, data structures)
│   ├── editors/             # Editors and UI code (View3D, Outliner, Properties, Node Editor)
│   │   └── space_logic/     # Dedicated Logic Bricks visual programming workspace
│   ├── windowmanager/       # Event dispatch, operator management, and window handling
│   ├── modifiers/           # Procedural mesh modifiers
│   ├── render/              # Rendering architecture (EEVEE, Cycles)
│   └── python/              # Python RNA bindings for editor-time tools (bpy)
│
├── source/gameengine/       # Native Real-Time Game Engine Layer (UPBGE)
│   ├── Ketsji/              # Main real-time game loop (KX_KetsjiEngine), KX_Scene, KX_GameObject
│   ├── GameLogic/           # SCA Logic Bricks engine (Sensors, Controllers, Actuators)
│   ├── Physics/             # Real-time physics abstraction (Bullet CcdPhysicsEnvironment)
│   ├── Converter/           # DNA-to-Ketsji translation (BL_Converter, BL_DataConversion)
│   ├── Launcher/            # Standalone runtime executable target (blenderplayer.exe)
│   ├── Rasterizer/          # Real-time EEVEE rendering pipeline bridge
│   ├── SceneGraph/          # Spatial transformation hierarchy (SG_Node)
│   └── Expressions/         # Expression controller evaluation
│
├── intern/                  # Supporting libraries
│   ├── moto/                # Matrix, vector, and transform math for the game engine
│   └── cycles/              # Cycles raytracing engine
│
└── scripts/                 # Python scripts and UI
    ├── startup/bl_ui/       # Interface definitions, Properties tabs (properties_game.py)
    └── addons_core/         # Core add-ons, including bge_netlogic (node-based game logic)
```

---

## 2. Dual-Upstream Tracking & Code Demarcation

Because this project harmonizes two distinct community upstreams into one unified platform, **strict comment demarcation is required** for all edits.

### A. Bforartists Interface & Ergonomics Markers
Used whenever modifying standard Blender menus, keymaps, layouts, or adding icon toolbars:
```cpp
/*bfa*/
// Bforartists UI modification or toolbar hook
/*bfa end*/
```
```python
# BFA
# Bforartists interface customization
```
* **UI Checkbox Alignment Rule**: In layout code (both C++ and Python), checkboxes must always float left for visual consistency across Bforartists themes.

### B. UPBGE Game Engine Integration Markers
Used whenever adding game engine hooks, game logic operators, conversion routines, or physics properties:
```cpp
/* *************** UPBGE ***************** */
// Native Game Engine integration hook, DNA extension, or engine callback
/* *********** End of UPBGE ************** */
```
```python
# *************** UPBGE *****************
# Game tab properties, logic brick interfaces, or playtest operators
# *********** End of UPBGE **************
```

---

## 3. Dual Python Execution Runtimes: `bpy` vs `bge`

Developers must distinguish between the two separate execution environments:

### 1. Editor & Tooling Time (`bpy`)
* Runs inside the interactive Blender/Bforartists authoring application.
* Uses `bpy.types.Panel`, `bpy.types.Operator`, and `bpy.props`.
* Manages scene configurations, level assembly, and data serialization.
* Exposed in `source/blender/python/` and `scripts/startup/bl_ui/`.

### 2. Real-Time Game Runtime (`bge`)
* Runs during viewport playtesting (pressing `P` or the Header Play button) and inside `blenderplayer.exe`.
* Uses `bge.logic`, `bge.events`, `bge.render`, and `bge.types.KX_GameObject`.
* **Python Game Components** (`bge.types.KX_PythonComponent`):
  * Modular object scripts attached to game entities.
  * Must implement `start(self, args)` and `update(self)` callbacks.
  * Property arguments are declared via an `args = OrderedDict([...])` class attribute.
* **NetLogic Node Trees**: Visual node-based game logic via `scripts/addons_core/bge_netlogic/`.
* **CRITICAL**: Never call blocking editor operators (`bpy.ops.*`) or heavy scene mutations from inside the real-time game loop (`bge`), as doing so stalls framerates and fails inside standalone game builds.

---

## 4. DNA Data Structures & Game Serialization

* All persistent state saved in `.blend` files is defined in `source/blender/makesdna/DNA_*.h`.
* **Game Engine State**:
  * `DNA_scene_types.h`: `GameData` (`scene->gm`) defines physics frequency, gravity, occlusion culling, embedded/standalone resolution, and rendering framerates.
  * `DNA_controller_types.h`, `DNA_sensor_types.h`, `DNA_actuator_types.h`: Logic brick definitions.
  * `DNA_python_proxy_types.h`: Serialization of Python Components on objects.
* **Compatibility Rule**: When adding or altering fields in DNA structures, maintain structure alignment, document padding, and update versioning patches in `source/blender/blenloader/intern/versioning_upbge.cc`.

---

## 5. Build System & Developer Workflows

Building produces two primary executables:
1. `Bforgamedevs.exe` — The 3D creation editor with embedded game playtesting.
2. `blenderplayer.exe` — The standalone game distribution runner.

### Windows (Primary / Tested Platform)
```powershell
# 1. Update precompiled libraries via Git-LFS:
make.bat update

# 2. Build with Ninja (Fastest incremental compile):
make.bat ninja release

# Or standard MSBuild:
make.bat release
```

### Linux & macOS (Experimental)
```bash
# Update dependencies:
python3 build_files/utils/make_update.py

# Out-of-source CMake build:
mkdir build_linux && cd build_linux
cmake ../ -GNinja -DCMAKE_BUILD_TYPE=Release
ninja install
```

---

## 6. Coding Standards & Conventions

* **Header Guards & Licenses**: Every file must start with an SPDX identifier:
  `/* SPDX-License-Identifier: GPL-2.0-or-later */`
* **C++ Conventions**:
  * Code in `source/blender/` uses the `blender::` namespace.
  * Prefer modern C++ (RAII, typed spans, references) over raw pointers where applicable.
  * Maintain strict null-checks during scene conversion in `source/gameengine/Converter/`.
* **Python Formatting**: `autopep8` configured in `pyproject.toml` (aggressive level 2).
* **Module Prefixes**:
  * `BKE_` - BlenKernel
  * `BLI_` - BlenLib
  * `UI_` - User Interface
  * `KX_` - Ketsji Engine
  * `SCA_` - Sensor/Controller/Actuator Logic
  * `PHY_` - Physics Abstraction Layer
