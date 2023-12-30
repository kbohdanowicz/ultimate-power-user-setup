## Display content in English and use Polish keyboard.md
1. Set English language 
2. Add Polish keyboard 
3. Remove English keyboard

## Run on startup
1. Create a shortcut to the executable or script
2. Paste the shortcut to
```
C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```
or create a task in task scheduler that runs at startup

## Stop PC from waking up after sleep
https://support.microsoft.com/en-us/topic/pc-automatically-wakes-from-sleep-mode-ii-5b98d03e-427b-b007-046a-3db8ebe2c2a2
https://superuser.com/questions/113801/why-does-my-windows-computer-immediately-turn-back-on-after-sleep-hibernate

### Show devices that caused the wake up
```ps
powercfg -devicequery wake_armed
```

### Blurry text in apps on Windows
This happened to me a couple of days ago and this fixed it for me.

1. Go to Nvidia Control Panel by Clicking on Your Desktop and Clicking on "NVIDIA Control Panel"
2. Once in Nvidia Control Panel Click on the Tab "Manage 3D settings"
3. Click on the Restore Button.
4. Make sure that antialiased-FXAA if turned OFF

Once that's done

4. Go to your windows search bar and search up "SystemPropertiesPerformance.exe"
5. Once in SystemPropertiesPerformance.exe uncheck "Smooth edges of Screen Font" and "Use drop shadows for icons on the desktop"

RESTART YOUR PC

6. Open the application that you have been having problems with.  If it's fixed then you're good.  

**FOR PEOPLE THAT DONT LIKE THE LOOK OF TEXT NOW**

7. Go Back to SystemPropertiesPerformance.exe and recheck "Smooth edges of Screen Font" and "Use drop shadows for icons on the desktop"
8. This should make everything look normal and fix the weird blurry text.


***YOU MIGHT NEED TO GO TO TASK MANAGER AND RESTART AN APPLICATION FOR THE EFFECTS TO BE APPLIED***
