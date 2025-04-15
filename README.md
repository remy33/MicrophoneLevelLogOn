[Clumsily Forked from](https://github.com/Vortiago/MicrophoneLevelGuard)

# MicrophoneLevelGuard

A PowerShell script that set your microphone's volume at a specified level. This is useful when certain applications or system events unexpectedly change your microphone volume.
Run it every system login.

## Features

-   Automatically restores volume to desired level when script runs
-   Includes WhatIf support for testing

## Requirements

-   Windows PowerShell or PowerShell Core
-   AudioDeviceCmdlets PowerShell module (automatically installed if missing)

## Installation

1. Clone this repository or download the script:

```powershell
git clone https://github.com/Vortiago/MicrophoneLevelGuard.git
```

2. Navigate to the script directory:

```powershell
cd MicrophoneLevelGuard
```

3. Run the install script to install script on log in with Task Scheduler,
   Right click and choose "Run with PowerShell" or run the following command:

```
 powershell.exe .\Install.ps1
```

## Usage

Run the script with default settings will set volume to 100%:

```powershell
.\MicrophoneLevelGuard.ps1
```

Set a specific volume level (e.g., 75%):

```powershell
.\MicrophoneLevelGuard.ps1 -DefaultVolume 75
```

Show detailed progress with verbose logging:

```powershell
.\MicrophoneLevelGuard.ps1 -DefaultVolume 50 -Verbose
```

Preview changes without applying them:

```powershell
.\MicrophoneLevelGuard.ps1 -DefaultVolume 80 -WhatIf
```

View help and usage information:

```powershell
.\MicrophoneLevelGuard.ps1 -Help
```

## Parameters

-   `-DefaultVolume <0-100>`: Sets the target volume level (0-100%). If not specified, uses current volume.
-   `-Help`: Shows the help message with usage instructions.
-   `-Verbose`: Shows detailed progress messages.
-   `-WhatIf`: Shows what changes would be made without actually making them.

## How It Works

When started, it displays a list of all available input devices, highlighting the current default device.

## Troubleshooting

If you encounter permission issues, try running PowerShell as Administrator.

Common issues:

1. "Module not found" - The script will attempt to install the required module automatically
1. "Access denied" - Run PowerShell with administrative privileges
1. "No microphone detected" - Ensure your microphone is properly connected and recognized by Windows

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
