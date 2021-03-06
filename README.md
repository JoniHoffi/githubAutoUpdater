# AutoUpdater
A simple auto updater which waits for a new release from your github repository and downloads an asset from the release

## Installation
1. Install jq and curl
  - `sudo apt install jq`
  - `sudo apt install curl`
2. Download following Files: [updater.sh](updater.sh), [beforeInstalling.sh](beforeInstalling.sh) and [afterInstalling.sh](afterInstalling.sh)
3. Open [updater.sh](updater.sh) and edit the lines in code which are marked with `Configure Here` ![Configure Here Example](images/configureHere)
4. Edit [beforeInstalling.sh](beforeInstalling.sh) and [afterInstalling.sh](afterInstalling.sh) so that it is tailored to your program. [Example](#BeforeAndAfter)
5. Start the [updater.sh](updater.sh). We recommend to use a screen for it.

## Which asset should be downloaded?
You can configure which asset should be downloaded. In the picture below you can see which number is which asset!
![Asset Number Example](images/assets.png)

> How to select which assets should be downloaded?

You can start the bash wit the argument "-a" for example --> "./updater.sh -a 1" --> This will download asset 1

> Can i select multiply assets which should be downloaded?

Not at the moment but this feature is planned

## BeforeAndAfter
[beforeInstalling.sh](beforeInstalling.sh) and [afterInstalling.sh](afterInstalling.sh) are scripts which are executed before and after the update is executed.
> What can I use this for?
1. You can execute your own commands before and after installation for example:
```bash
# BeforeInstallation
# Close the old screen where your program is running
screen -X -S program kill
# Delete the old file
rm program.jar
```

```bash
# AfterInstallation
# Create a new screen and run the new updated program
screen -L -S program
# Start the new program
java -jar program.jar
```
