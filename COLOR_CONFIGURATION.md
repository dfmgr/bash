# Color Configuration Guide

## Adaptive Color System

The shell configurations now include **automatic background detection** to ensure colors are readable on both light and dark terminal backgrounds.

## How It Works

### Automatic Detection

Colors automatically adapt based on your terminal background:

1. **Dark Backgrounds** (default)
   - Red: Uses bright red (color 9) for better visibility
   - White: Uses bright white (color 97)
   - Blue: Uses bright blue (color 12)

2. **Light Backgrounds**
   - Red: Uses normal red (color 1)
   - White: Uses normal white (color 37)
   - Blue: Uses bright blue (color 12)

### Detection Methods

The system tries multiple methods to detect your background:

1. **User Override** (highest priority)
   ```bash
   export TERMINAL_BACKGROUND="light"  # or "dark"
   ```

2. **COLORFGBG Variable**
   - Set by some terminals (xterm, rxvt, etc.)
   - Format: `foreground;background`
   - Values 0-7 = dark, 8-15 = light

3. **Default**
   - Falls back to "dark" if cannot detect

## Manual Configuration

### Set Your Background Type

Add to your `~/.profile` or `~/.bash_profile`:

```bash
# For light terminal backgrounds
export TERMINAL_BACKGROUND="light"

# For dark terminal backgrounds
export TERMINAL_BACKGROUND="dark"
```

### Check Current Setting

```bash
echo $TERMINAL_BG
```

### Test Colors

```bash
source ~/.config/bash/functions/00-functions.bash
printf_red "Red text test"
printf_green "Green text test"
printf_blue "Blue text test"
printf_yellow "Yellow text test"
```

## Color Improvements

### What Changed

| Color | Dark Background | Light Background | Notes |
|-------|----------------|------------------|-------|
| Red | Bright (91m) | Normal (31m) | Better visibility on dark |
| Blue | Bright (94m) | Bright (94m) | Readable on both |
| Yellow | Bright (93m) | Bright (93m) | High contrast |
| White | Bright (97m) | Normal (37m) | Adaptive |
| Green | Normal (32m) | Normal (32m) | Works well on both |
| Cyan | Normal (36m) | Normal (36m) | Excellent on both |

### Functions Using Adaptive Colors

- `printf_red()` - Errors, warnings
- `printf_error()` - Error messages
- `printf_execute_error()` - Command failures

## Troubleshooting

### Colors Don't Look Right?

1. **Check your terminal background**:
   ```bash
   echo $TERMINAL_BG
   ```

2. **Override if needed**:
   ```bash
   export TERMINAL_BACKGROUND="light"  # or "dark"
   source ~/.bashrc
   ```

3. **Check COLORFGBG**:
   ```bash
   echo $COLORFGBG
   # Should be "foreground;background" like "15;0" or "0;15"
   ```

### Supported Terminals

- ✅ xterm (with COLORFGBG)
- ✅ rxvt/urxvt (with COLORFGBG)
- ✅ Any terminal (with manual override)
- ⚠️ Some terminals may require manual configuration

### Terminal-Specific Notes

**gnome-terminal / konsole**: Usually don't set COLORFGBG, use manual override

**iTerm2 / Terminal.app**: Usually don't set COLORFGBG, use manual override

**Windows Terminal**: Use manual override

## Examples

### Switching Terminals

If you switch between light and dark terminals:

```bash
# In your ~/.profile or ~/.bashrc
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
  export TERMINAL_BACKGROUND="light"
else
  export TERMINAL_BACKGROUND="dark"
fi
```

### Time-Based

```bash
# Light during day, dark at night
hour=$(date +%H)
if [ $hour -ge 8 ] && [ $hour -lt 18 ]; then
  export TERMINAL_BACKGROUND="light"
else
  export TERMINAL_BACKGROUND="dark"
fi
```

## Advanced: Custom Colors

If you want to customize specific colors beyond the adaptive system:

```bash
# In ~/.config/local/bash.local
# Override after color initialization
RED="\033[0;91m"   # Always use bright red
BLUE="\033[0;34m"  # Always use dark blue
```

## ZSH and Fish

Similar adaptive color logic is being implemented for:
- ZSH: Coming soon
- Fish: Man page colors already optimized

For now, manually set `TERMINAL_BACKGROUND` in your shell's RC file.
