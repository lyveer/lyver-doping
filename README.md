# \# 💉 Lyver Doping - Advanced Stamina \& Overdose System

# 

# A standalone, high-quality medical script for RedM (RSG Core) featuring a \*\*Doping Syringe\*\* item. This script provides an instant tactical advantage by restoring stamina but introduces a punishing \*\*Overdose Mechanic\*\* to balance gameplay.

# 

# \## ✨ Features

# 

# \* \*\*⚡ Instant Recovery:\*\* Refills both Stamina Bar and Core instantly (100%).

# \* \*\*💉 Realistic Animation:\*\* Uses the `p\_cs\_syringe01x` prop with a custom injection sequence.

# \* \*\*😵 Progressive Overdose System:\*\*

# &nbsp;   \* \*\*1st Dose:\*\* Full Stamina Refill + Visual Rush (Optional).

# &nbsp;   \* \*\*2nd Dose:\*\* \*\*Warning Stage.\*\* You receive a mental warning: \*"You used too much!"\*. No penalties yet.

# &nbsp;   \* \*\*3rd Dose:\*\* \*\*System Failure.\*\* The screen slowly fades to black (Soft Fade), and the player faints.

# \* \*\*🔄 The Recovery Loop:\*\*

# &nbsp;   \* After the 3rd dose (overdose), the player enters a "Collapse Loop".

# &nbsp;   \* They wake up, walk for a few seconds, then the screen darkens and they faint (ragdoll) repeatedly.

# &nbsp;   \* This cycle continues for a configurable duration (Default: 2 minutes).

# \* \*\*⏱️ Auto-Reset:\*\* The overdose counter automatically resets if the player rests for a while (Default: 15 minutes).

# \* \*\*⚙️ Fully Configurable:\*\* Toggle screen effects, adjust cooldowns, and fall durations in `config.lua`.

# 

# \## 📦 Dependencies

# 

# \* `rsg-core`

# \* `rsg-inventory`

# \* `rNotify` (or compatible notification script)

# 

# \## 🛠️ Installation

# 

# 1\.  \*\*Download:\*\*

# &nbsp;   Place the `lyver-doping` folder into your server's `resources` directory.

# 

# 2\.  \*\*Add Item to Core:\*\*

# &nbsp;   Open `rsg-core/shared/items.lua` and paste this line:

# 

# &nbsp;   ```lua

# &nbsp;   doping = { name = 'doping', label = 'Doping Syringe', weight = 20, type = 'item', image = 'doping.png', unique = false, useable = true, shouldClose = true, description = 'Restores stamina immediately.' },

# &nbsp;   ```

# 

# 3\.  \*\*Add Image:\*\*

# &nbsp;   Make sure you have a `doping.png` image in your `rsg-inventory/html/images/` folder.

# 

# 4\.  \*\*Server Config:\*\*

# &nbsp;   Add this to your `server.cfg`:



# &nbsp;   ```

# &nbsp;   ensure lyver-doping



# &nbsp;   ```

# 

# 5\.  Restart:

# &nbsp;   Restart the server .

# 

# \## ⚙️ Configuration

# 

# Check `config.lua` to adjust:

# \* `Config.EnableScreenEffect`: Set to `false` to disable the visual drug filter completely.

# \* `Config.ResetTime`: How long to wait before the overdose counter resets (Clean slate).

# \* `Config.DrunkDuration`: How long the "Fainting Loop" lasts.

# 

TEBEX: https://lyver.tebex.io
Discord: https://discord.gg/vWZddksPPv
===

# &nbsp;

# 📝 License

Free to use on RedM servers.


===

