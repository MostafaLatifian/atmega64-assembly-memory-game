# 💡 Two-Player LED Memory Game (ATmega64 Assembly)

A classic **Two-Player Memory Game** implemented on the **ATmega64** microcontroller using Assembly language. The system challenges two users to replicate a displayed LED pattern within a limited time, utilizing timers and interrupts for precise control.

## 🌟 Project Goal

The primary objective was to design and implement a digital logic system for a two-player memory game.
1.  **Player 1** enters a specific **LED sequence/pattern** using an input method.
2.  **Player 2** must observe and **replicate the exact sequence** within a **limited timeframe**.
3.  The system manages the display of the pattern and the time constraint using **timers** and **interrupts**.

***

## ⚙️ Core Technologies & Tools

This project is a low-level embedded system implementation.

* **Microcontroller:** Atmel **ATmega64**
* **Programming Language:** **Assembly** (for direct hardware control and optimal performance)
* **Development Environment (IDE):** **Atmel Studio**
* **Simulation & Design:** **Proteus** (Used for hardware circuit design, I/O mapping, and simulation)
* **Documentation:** Project Report/Documentation

***

## ✨ Key Features

* **Two-Player Mode:** Supports the core game loop for two separate users.
* **Timer-Based Challenge:** Implements a strict, time-limited window for Player 2 to reproduce the pattern using the ATmega64's **internal timers**.
* **Interrupt-Driven Input:** Utilizes **interrupts** for reliable and precise pattern entry and system state management.
* **LED Pattern Display:** Clear visual feedback using **LEDs** to show the sequence to be memorized.
* **Low-Level Optimization:** Code written entirely in **Assembly** for fast execution and minimal resource usage.

***

## 🛠️ Installation & Setup (Simulation)

Since the project is implemented on a specific microcontroller in Assembly, the standard method for viewing the results is via simulation.

1.  **Install Proteus:** Ensure you have the Proteus simulation software (ISIS/ARES) installed.
2.  **Download Files:** Clone this repository and locate the following files:
    * **Assembly Source Code:** `[project_name].asm` (The core logic)
    * **Hex File:** `[project_name].hex` (The compiled output)
    * **Proteus Schematic:** `[project_name].pdsprj` (The circuit design file)
3.  **Load Simulation:**
    * Open the `.pdsprj` file in **Proteus**.
    * **Double-click** the ATmega64 component in the schematic.
    * Browse and load the compiled **`.hex`** file into the "Program File" field.
4.  **Run:** Click the **Play/Run** button in Proteus to start the simulation and begin the game.

***

## 📚 Project Deliverables

The following artifacts were produced as part of the project:

* **Assembly Source Code:** The complete source code for the ATmega64 written in Assembly.
* **Project Report:** A comprehensive report detailing the design process, hardware mapping, algorithm, and implementation challenges.
* **Proteus Design:** The full circuit diagram and simulation environment setup.

