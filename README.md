# Blender for Gamedevs

> ### 🤖 **AI Modified**
> *This repository utilizes AI assistance to harmonize and port UPBGE into Bforartists. **All AI-assisted modifications are strictly scoped and demarcated within dedicated comment blocks** across the codebase.*

> ### $\color{red}\textsf{\textbf{Experimental}}$
> This is an experimental release: some features may not work as expected, and Linux/macOS builds are currently untested. **We actively welcome community testing, feedback, bug reports, and code contributions!**

**Blender for Gamedevs** brings together two powerful community-driven evolutions of Blender:
1. **[Bforartists](https://www.bforartists.de/)**: The artist-centric fork of Blender focused on delivering a streamlined, highly visual, and intuitive graphical user interface with customizable toolbars, colored iconography, and ergonomic layouts.
2. **[UPBGE](https://upbge.org/)** (**Uchronia Project Blender Game Engine**): The complete, modernized Blender Game Engine fork created by Tristan Porteries and friends in September 2015, maintaining and advancing real-time game development, logic bricks, Bullet physics, Python components, and standalone game distribution.

This project merges both systems into a unified creative suite: the intuitive, artist-first workflow of Bforartists paired seamlessly with the native real-time game development capabilities of UPBGE.

---

## Overview

### Complete 3D Creation & Game Pipeline
This suite supports the entirety of the 3D art and interactive entertainment pipeline:
- **3D Art & Animation**: Modeling, sculpting, UV unwrapping, texturing, rigging, animation, simulation, rendering (EEVEE & Cycles), compositing, and video sequence editing.
- **Real-Time Game Development**: Visual logic programming (Logic Bricks), Python game scripting and components, real-time Bullet physics, 3D audio (Audaspace), dynamic video textures (VideoTexture), embedded viewport playtesting, and standalone game exporting with the `blenderplayer` executable.

![Bforartists Interface](https://www.bforartists.de/wp-content/uploads/2020/04/modelingbfa2.jpg)

---

## Key Features & Highlights

### 1. Intuitive, Artist-First User Interface (Bforartists)
Blender's default interface can present a steep learning curve with heavy reliance on hotkeys and deeply nested menus. Bforartists re-engineers the interface for speed, clarity, and ergonomics:
- **Dedicated Keymap**: Reduced to essential hotkeys with full navigation and operations possible purely via mouse and menus.
- **Cleaned-up & Extended Menus**: Eliminated redundant menu entries while surfacing formerly hotkey-only operators into clear, categorized menus.
- **Colored Iconography (Over 2x Icons)**: Comprehensive, color-coded icon set across all editors for rapid visual recognition of tools and data blocks.
- **Customizable Toolbars & Toolshelf Tabs**: Quick-access icon toolbars and tabbed toolshelves to speed up access to frequently used tools.
- **Artist-Friendly Layouts**: Readable default themes, improved tooltips, and sensible defaults.
- **Built-in Usability Addons**: Pre-installed workflow boosters such as Reset 3D View and Set Dimensions (world-coordinate scaling in Edit Mode).
- **Tool-Centric Documentation**: Rewritten manual focusing on tools, menus, and artist workflows rather than hotkey memorization.

### 2. Full-Featured Native Game Engine (UPBGE)
Following the Blender Foundation's removal of the Blender Game Engine (BGE) in Blender 2.80, UPBGE continued as the dedicated platform for native real-time game creation in Blender. Integrated directly into the Bforartists interface, it offers:
- **Zero-Friction Iteration**: Create, rig, animate, wire logic, and playtest your game directly inside the 3D Viewport with one click (`P` or the Header Play button)—no external engine export required.
- **Logic Bricks Editor**: Fast, visual node-style programming with Sensors, Controllers, and Actuators for rapid prototyping and gameplay design without writing code.
- **Python Game Components & API**: Full `bge` API and Python Component system for modular, object-oriented gameplay scripting.
- **Real-Time Bullet Physics**: Native rigid bodies, soft bodies, character controllers, collision callbacks, ragdolls, and vehicle physics.
- **Integrated Game Settings**: Dedicated `Game` tab in Properties (`BCONTEXT_GAME`), render game resolution controls, embedded playtesting, and standalone game launch options.
- **Standalone Distribution**: Package and distribute games as standalone executables powered by the built-in `blenderplayer`.

---

## Differences to Vanilla Blender

| Feature | Vanilla Blender | UPBGE Baseline | Blender for Gamedevs |
| :--- | :--- | :--- | :--- |
| **User Interface** | Hotkey-centric, monochrome icons | Standard Blender UI | Streamlined, colored iconography, customizable toolbars |
| **Navigation & Menus** | Requires keyboard shortcuts | Standard Blender menus | Full mouse navigability, all tools accessible in menus |
| **Game Engine (BGE)** | Removed (v2.80+) | Yes (EEVEE real-time engine) | **Fully Integrated with Bforartists UI** |
| **Logic Bricks Editor** | Removed | Yes | **Yes (Integrated workspace & editor)** |
| **Standalone Player** | None | Yes (`blenderplayer`) | **Yes (`blenderplayer.exe` included)** |
| **File Compatibility** | `.blend` format | `.blend` format | **Full `.blend` compatibility with Blender & UPBGE** |

For more examples of UI differences, visit: [Bforartists Differences to Blender](https://www.bforartists.de/the-differences-to-blender/)

---

## Getting Started

### Media & Tutorials
- **Bforartists Introduction Video**:
  [![Youtube Introduction](https://img.youtube.com/vi/xAJQsKRi3sY/0.jpg)](https://www.youtube.com/watch?v=xAJQsKRi3sY)
- **Bforartists Quickstart Playlist**: [YouTube Playlist](https://www.youtube.com/watch?v=sZlqqMAGgMs&list=PLB0iqEbIPQTZArhZspyYSJOS_00jURpUB)
- **Bforartists Release Notes**: [Bforartists Release Notes](https://www.bforartists.de/wiki/release-notes)
- **UPBGE Release Notes**: [UPBGE Release Notes](https://github.com/UPBGE/blender/wiki/Release-notes)
- **UPBGE Documentation**: [UPBGE Manual & API Reference](https://upbge.org/docs/latest/manual/index.html)
- **Manual Repository**: [Bforartists Manual on GitHub](https://github.com/Bforartists/Manual)

---

## Building from Source

Building this project follows the standard Blender and Bforartists build workflows.

### Prerequisites & Dependencies
To keep repository clone times fast, precompiled binary libraries (`lib/`) are not committed directly to Git. They are fetched automatically on demand:
- **Windows (Primary / Tested)**: Running `make.bat` will detect missing libraries and prompt to download them automatically via Git/Git-LFS (`lib/windows_x64`).
- **Linux & macOS (Experimental / Untested — May Not Work)**: Porting efforts have currently been focused on and verified on Windows x64. Building on Linux or macOS is experimental, has not yet been tested, and might not compile or work out of the box. Running `make update` attempts to fetch platform libraries.
- **Reference Guides**:
  - [Blender Handbook - Windows](https://developer.blender.org/docs/handbook/building_blender/windows/)
  - [Blender Handbook - Linux](https://developer.blender.org/docs/handbook/building_blender/linux/) *(Untested)*
  - [Blender Handbook - macOS](https://developer.blender.org/docs/handbook/building_blender/mac/) *(Untested)*

### Windows Build Quickstart
```powershell
# 1. Download/update precompiled dependencies (if not already done):
make.bat update

# 2. Build with Ninja (Fastest):
make.bat ninja release

# Or standard MSBuild:
make.bat release

# Or if you configured CMake manually with Ninja:
ninja install
```
Building compiles both the main `Bforgamedevs.exe` editor and the standalone `blenderplayer.exe` runtime.

> **Note**: Nightly automated CI builds are primarily for testing compiler health and may lack proprietary codecs, CUDA, or OptiX. For daily driver builds, refer to official release downloads.

---

## Community & Feedback

Both Bforartists and UPBGE thrive thanks to enthusiastic communities of artists, developers, and game creators. We welcome feedback, bug reports, feature requests, and code contributions!

- **Issue & Bug Tracker**:
  - [Bforartists Issue Tracker](https://github.com/Bforartists/Bforartists/issues)
  - [UPBGE Issue Tracker](https://github.com/UPBGE/blender/issues)
- **Project Websites**:
  - [Bforartists Website](https://www.bforartists.de/)
  - [UPBGE Website](https://upbge.org/)

---

## License

Blender, Bforartists, and UPBGE are licensed under the **GNU General Public License, Version 3** (GPLv3). Individual third-party libraries and modules may have different but compatible open-source licenses.

See [blender.org/about/license](https://www.blender.org/about/license) and the included [`COPYING`](COPYING) file for details.
