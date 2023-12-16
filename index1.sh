#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# logo
echo -e "\n${GREEN}❚█══════${RED}indeX${GREEN}══════█❚${NC}"
echo -e "${GREEN}=====================${NC}"
echo -e "${GREEN}   Welcome To indeX${NC}"
echo -e "${GREEN}=====================${NC}\n"


read -p "$(echo -e ${RED}${WHITE}"Enter your preferred ASN: "${NC}) " asn
echo -e "${GREEN}===================================================${NC}"
read -p "$(echo -e ${RED}${WHITE}"Enter the filename to save the IP ranges in: "${NC}) " output_file
read -p "$(echo -e ${RED}${WHITE}"Enter the filename to save the live_hosts: "${NC}) " live_hosts_file
read -p "$(echo -e ${RED}${WHITE}"Enter the filename to save the NMAP output: "${NC}) " final_results_file
read -p "$(echo -e ${RED}${WHITE}"Do you want to scan for vulnerabilities? (y/n): "${NC}) " scan_vulnerabilities
echo -e "${GREEN}===================================================${NC}"

# whois command to extract IP ranges
whois_output=$(whois -h whois.radb.net -- "-i origin $asn" | grep -Eo "([0-9.]+){4}/[0-9]+" | uniq)

if [ -n "$whois_output" ]; then
    echo "$whois_output" > "$output_file"
    echo -e "${GREEN}IP ranges saved to $output_file${NC}"
    echo -e "${GREEN}============================${NC}"
    echo -e "${GREEN}Nmap Scan Might Take A While. Take a break.${NC}\n"

    # Scan for live ranges/host  
    nmap -sn -iL "$output_file" | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' >> "$live_hosts_file"
   

    if [ "$scan_vulnerabilities" == "y" ]; then
        nmap --script=http-title --script vuln -sS -sV --top-ports 1000 -T4 -Pn -iL "$live_hosts_file" -oN "$final_results_file"
        echo -e "${GREEN}Vulnerability scan completed. Results saved to $final_results_file${NC}"
    else
        nmap -sS -sV --top-ports 100 -T4 -Pn -iL "$live_hosts_file" -oN "$final_results_file"
        echo -e "${GREEN}Nmap scan completed. Results saved to $final_results_file${NC}"
    fi

else
    echo -e "${RED}No IP ranges found for ASN $asn :(${NC}"
fi
