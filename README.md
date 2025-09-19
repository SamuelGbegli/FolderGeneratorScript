# FolderGeneratorScript
This is a PowerShell script designed for the user to create a set of folders in a single location.

## Important (read first)
PowerShell scripts can potentially damage your system or make undesired modifications. Only run the script if you have read and fully understood the script and what it does.

The script may not work on your system based on your system's execution policies. For more information please read the following article: [https:/go.microsoft.com/fwlink/?LinkID=135170](https:/go.microsoft.com/fwlink/?LinkID=135170)

## How to use the script
In a terminal, navigate to the folder containing the script and enter the following:

`./generateFolders.ps1 -Path {path name} -FolderNames {"Folder 1", "Folder 2", etc.}`

If no value is passed for Path, folders will be created in the same location as the script.

If no values are passed for FolderNames, you will be a shown a prompt similar to this:

``` cmdlet generateFolders.ps1 at command pipeline position 1
Supply values for the following parameters:
(Type !? for Help.)
FolderNames[0]:
```
If this happens, type in the name of the folder you want to create, then press enter to add another name. To run the script, press enter when there is no text in the terminal.

The script will fail to run if no folder names are specified or the path given does not exist. A folder will also not be created if the name supplied is invalid or another folder with the same name exists.

When the script is complete, you will see the text `Completed script execution.` on the terminal. The number of folders created, folders skipped due to an identically named folder existing, and folders that could not be created due to an error will also appear.
