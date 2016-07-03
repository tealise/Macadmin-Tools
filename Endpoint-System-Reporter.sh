#!/bin/bash

# Variables
RED='\033[0;31m'
PURPLE='\033[0;35m'
LGRAY='\033[0;37m'
LBLUE='\033[1;36m'
NC='\033[0m' # No Color

clear
echo -e "${PURPLE}##############################################"
echo "# Endpoint System Reporter                   #"
echo "# Created by Joshua Nasiatka (Bitcraft Labs) #"
echo "# Version 0.1 (07.02.16)                     #"
echo -e "##############################################${NC}"
echo

echo -e "${LGRAY}Gathering system data...\nThis may take a few minutes.${NC}\n"

# Computer Name
CompName=$(scutil --get ComputerName)

# User List
UserList=$(dscl . list /Users | grep -v ^_.*)

# Uptime
Uptime=$(uptime)

# System Info
echo -e "${LBLUE}Looking at System Information${NC}"
Model=$(curl -s http://support-sp.apple.com/sp/product?cc=`system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-` |
    sed 's|.*<configCode>\(.*\)</configCode>.*|\1|')
Serial=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
Filevault=$(fdesetup status)
InstalledOSName=$(sw_vers -productName)
InstalledOS=$(sw_vers -productVersion)
InstalledOSBuild=$(sw_vers -buildVersion)
IPAddr=$(ifconfig en2 | grep inet | awk '{print $2}' | cut -d':' -f2)
IPAddr2=$(ifconfig | grep 'Link\|inet' | grep 'inet ')

# Available Updates
echo -e "${LBLUE}Checking for Software Updates${NC}"
SystemUpdates=$(softwareupdate -l)

# Hardware Specs
echo -e "${LBLUE}Obtaining Hardware Specs${NC}"
Processor=$(sysctl -n machdep.cpu.brand_string)
Memory=$(system_profiler SPMemoryDataType | grep 'Memory: ' | awk 'NR==1' | cut -c 15-)
Graphics=$(system_profiler SPDisplaysDataType)
Drives=$(system_profiler SPStorageDataType)
HWSpecs=$(echo -e "\tProcessor:\t$Processor\n\tMemory:\t\t$Memory")

echo
echo -e "${RED}Computer Name..........:${NC} $CompName"
echo -e "${RED}Uptime.................:${NC}$Uptime"
echo -e "${RED}Model Number...........:${NC} $Model"
echo -e "${RED}Serial Number..........:${NC} $Serial"
echo -e "${RED}Current macOS Version..:${NC} $InstalledOSName $InstalledOS ($InstalledOSBuild)"
echo -e "${RED}Encryption Status......:${NC} $Filevault"
echo -e "${RED}IP Address(es).........:${NC} \n$IPAddr2"
echo -e "${RED}Hardware Specs.........:${NC} \n$HWSpecs"

echo
echo -e "${RED}"
echo -e "****************************"
echo -e "*        User List         *"
echo -e "****************************${NC}\n"
echo -e "$UserList"

echo
echo -e "${RED}"
echo -e "****************************"
echo -e "* Available System Updates *"
echo -e "****************************${NC}\n"
echo -e "$SystemUpdates"

echo -e "${RED}"
echo -e "****************************"
echo -e "*     Attached Volumes     *"
echo -e "*     (Detailed Info)      *"
echo -e "****************************\n${NC}\n$Drives"

echo -e "${RED}"
echo -e "****************************"
echo -e "*   Displays / Graphics    *"
echo -e "*     (Detailed Info)      *"
echo -e "****************************\n${NC}\n$Graphics"
