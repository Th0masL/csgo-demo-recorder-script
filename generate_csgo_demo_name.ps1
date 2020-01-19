######################################################################################
#                                                                                    #
# CSGO Demo Recorder Script                                                          #
# By : Thomas 'SAP' L.                                                               #
# Version : 1.0                                                                      #
#                                                                                    #
# https://github.com/Th0masL/csgo-demo-recorder-script/                              #
#                                                                                    #
######################################################################################
#                                                                                    #
# Description :                                                                      #
# This script allow automated demo recording in CSGO.                                #
# Visit the GitHub page for more information.                                        #
#                                                                                    #
# To use this script :                                                               #
# 1) Save this file locally. Example: C:\scripts\generate_csgo_demoname.ps1          #
# 2) Schedule its execution with Windows' Task Scheduler often (ie. every 5 minutes) #
# 3) Edit your CSGO config.cfg to add a bind for executing the record.cfg file.      #
#    Example, update your TAB bind to :                                              #
#    bind "TAB" "+showscores; exec record.cfg"                                       #
#                                                                                    #
######################################################################################

# Read regedit to get the Steam Folder Path and the User ID of the current logged in user
$USER_ID = (Get-ItemProperty -path 'HKCU:\Software\Valve\Steam\ActiveProcess').ActiveUser
$STEAM_PATH = (Get-ItemProperty -path 'HKCU:\Software\Valve\Steam').SteamPath

# If you don't want to use Regedit to get those values, you can define their value
# manually and comment out the lines above by adding '#'
# Example :
# $USER_ID = "012345"
# $STEAM_PATH = "C:\Program Files (x86)\Steam"

############ DO NOT EDIT BELOW ############

# Define the path of the CFG folder, where we will create the file record.cfg
$CSGO_CFG_FOLDER = "$STEAM_PATH\userdata\$USER_ID\730\local\cfg"

# Make sure the CSGO Cfg Folder exist
if ( (Test-Path "$CSGO_CFG_FOLDER") ) {

    # Get the date, with YYYYMMDD_HHMM format
    $DATE_NOW = Get-Date -format "yyyMMdd_HHmm"

    # Define the demo name, as demo_YYYYMMDD_HHMM.dem
    $DEMO_NAME = "demo_$DATE_NOW.dem"

    # Define the OUTPUT file as record.cfg in the CSGO_CFG_FOLDER
    $OUTPUT_FILE = "$CSGO_CFG_FOLDER\record.cfg"

    # Show the command we will use to record the next demo
    "Saving the command 'record $DEMO_NAME' in file '$OUTPUT_FILE' ..."

    # Save the line "record DEMO_NAME" to the OUTPUT_FILE
    Set-Content -Path "$OUTPUT_FILE" -Value "record $DEMO_NAME"
    
    # Wait 2 seconds before closing the program
    Start-Sleep -s 2
}
# If the User ID is empty, show an error message
elseif ( $USER_ID -eq "" ) {
    "Error - Unable to find a valid Steam User ID. Please verify that Steam is running."
    
    # Wait 10 seconds before closing the program
    Start-Sleep -s 10
}
# If the Folder does not exist, show an error message
else { 
    "Error - Unable to find the CSGO CFG Folder : $CSGO_CFG_FOLDER"
    "Please verify your Steam Installation Folder and your User ID"
    
    # Wait 10 seconds before closing the program
    Start-Sleep -s 10
}
