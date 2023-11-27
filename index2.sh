#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

echo -e "\n${GREEN}❚█══════${RED}indeX${GREEN}══════█❚${NC}"
echo -e "${GREEN}=====================${NC}"
echo -e "${GREEN}   Welcome To indeX${NC}"
echo -e "${GREEN}=====================${NC}\n"


RED="\033[0;31m"
GREEN="\033[0;32m"
WHITE="\033[1;37m"
NC="\033[0m"

shift $((OPTIND - 1))
input_file="$1"

# Check if a file is provided as an argument
if [ -z "$input_file" ]; then
    echo "Please provide a file containing domains/subdomains."
    exit 1
fi

if [ ! -f "$input_file" ]; then
    echo "File not found: $input_file"
    exit 1
fi

read -p "$(echo -e ${RED}${WHITE}"Do you want to display only IPs? (y/n)[Default displays domain_name&IP]: "${NC}) " display_ips
echo -e "${GREEN}===================================================${NC}"

# Loop through each line in the file
while IFS= read -r domain; do
    # Check if domain is empty
    if [ -n "$domain" ]; then
        # Use host command and awk to get the IP address
        ip=$(host "$domain" | awk '/has address/ {print $4}')

        # Check if IP is empty
        if [ -n "$ip" ]; then
            # Display the result based on user choice
            if [ "$display_ips" = "y" ]; then
                echo "$ip"
            else
                echo "Domain: $domain, IP: $ip"
            fi
        fi
    fi
done < "$input_file"

echo -e "${GREEN}===================================================${NC}"
read -p "$(echo -e ${RED}${WHITE}"Do you want to save the results to a file? (y/n): "${NC}) " save_to_file

if [ "$save_to_file" = "y" ]; then
    read -p "$(echo -e ${RED}${WHITE}"Enter the file name to save results: "${NC}) " output_file

   
    while IFS= read -r domain; do
    
        if [ -n "$domain" ]; then
            ip=$(host "$domain" | awk '/has address/ {print $4}')
            if [ -n "$ip" ]; then
                if [ "$display_ips" = "y" ]; then
                    echo "$ip" >> "$output_file"
                else
                    echo "Domain: $domain, IP: $ip" >> "$output_file"
                fi
            fi
        fi
    done < "$input_file"

    echo -e "${GREEN}${WHITE}Your file '$output_file' has been saved.${NC}"
    echo -e "${GREEN}===================================================${NC}"

    if [ "$display_ips" = "n" ]; then
        exit 0
    fi
  
    read -p "$(echo -e ${RED}${WHITE}"Do you want to perform an nmap scan? (y/n): "${NC}) " perform_nmap

    if [ "$perform_nmap" = "y" ]; then
       nmap -sS --script=http-title --top-ports 100 -T4 -Pn -iL "$output_file"
    fi
fi

