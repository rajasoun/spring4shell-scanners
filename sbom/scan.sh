#!/usr/bin/env bash

NC=$'\e[0m' # No Color
BOLD=$'\033[1m'
UNDERLINE=$'\033[4m'
RED=$'\e[31m'
GREEN=$'\e[32m'
BLUE=$'\e[34m'
ORANGE=$'\x1B[33m'

# raise error
function raise_error(){
  echo -e "${BOLD}${RED}${1}${NC}" >&2
  exit 1
}

# print git repository link. Exit if not git repository directory
function print_repo_details(){
    if git tag > /dev/null 2>&1; then
        repo_name=$(git ls-remote --get-url)
        echo -e "${BOLD}${ORANGE}Git Repository : ${NC}$repo_name\n"
    else
        echo -e "${BOLD}${RED}Not a Git Repository. ${NC}\n"
    fi
}


echo -e "${BOLD}${UNDERLINE}\n Spring4Shell Vulnerability Scanner - v1.0${NC}\n"
print_repo_details
echo -e "Scanning for CVE-2022-22965 Vulnerability"
package_count=$(syft packages dir:. -o table  | grep -e "spring-beans" -e "spring-webmvc" -e "spring-boot")

if [ $package_count != 0 ]; then 
    echo -e "\n ${RED}Vulnerablity Found 🔴 ${NC}\n"
else 
    echo -e "\n ${GREEN}Vulnerablity  NOT Found ✅ ${NC}\n"
fi 

echo -e "\n ${ORANGE}${UNDERLINE}Recommendation ${NC}\n"
echo -e "1. Upgrade Spring Framework 5.3.18+ or 5.2.20+"
echo -e "2. Upgrade Sprint Boot to 2.6.6"
