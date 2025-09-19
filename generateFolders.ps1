# Script to automatically create a set of folders specified by the user

<#
    Walkthrough:
    1. input output destination and list of folders' names
    2. if output destination is empty, revert to location of script
    3. if output destination does not exist, throw error and end
    4. if list of folders are empty, throw error and end
    5. for each folder name
        a. if file name is invalid, throw error and skip
        b. if file name is valid
            i. if folder already exists, throw error and skip
            ii. otherwise add folder
    6. print script is complete, and print folders created, skipped and invalid
#>

param (
    [Parameter(HelpMessage = "Please provide a valid path name (leave blank for current folder)")]
    [string]$Path,
    [Parameter(Mandatory, HelpMessage = "Please give a list of folder names you would like to create ")]
    [string[]]$FolderNames
)

# Checks if folder name is valid
function ValidateFileName {
    param (
        [string] $fileName
    )

     $invalidCharacterIndex = $fileName.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars())
     return $invalidCharacterIndex -eq -1
}

# Number of folders successfully created
$SuccessfulFolders = 0
# Number of folders not created due to path already existing
$ExistingFolders = 0
# Number of folders not created due to an error
$Errors = 0

# Sets path to the script's location if none is given by the user
If ($Path -eq "") {
    $Path = Get-Location
}

# Throws error and cancels executution if path does not exist
If(-Not (Test-Path $Path)){
    Throw "The path $Path does not exist. Cancelling request."
}

# Throws error and cancels executution if no folder names are given
If($FolderNames.Count -le 1){
    Throw "No folder names were given. Cancelling request."
}

# Cycles through folder names
foreach ($folder in $FolderNames) {
    try {
        # Checks if folder name is valid
        if(ValidateFileName -fileName $folder){
            # Checks if folder does not exist
            if(-Not (Test-Path "$Path\$folder")){
                # Creates new folder
                New-Item -Path $Path -Name $folder -ItemType "Directory"
                Write-Host "Successfully created folder $folder."
                $SuccessfulFolders ++
            }
            # Tells user folder exists
            else {
                Write-Warning "Folder $folder already exists."
                $ExistingFolders ++
            }
        }
        # Tells user folder name is invalid
        else {
            Write-Error "Folder name $folder is invalid."
            $Errors ++
        }
    }
    # Tells user of error if anything else goes wrong
    catch {
            Write-Error "An exception has occured: $($_.Exception.Message)"
            $Errors ++
    }
}

#Prints results to user
Write-Host "Completed script execution."
Write-Host "$SuccessfulFolders folder(s) created" -ForegroundColor Green
Write-Host "$ExistingFolders existing folder(s) found" -ForegroundColor Yellow
Write-Host "$Errors error(s) encountered" -ForegroundColor Red