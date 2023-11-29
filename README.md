# indeX

This is a composition of two tools. `indeX1` & `indeX2`

## indeX1
### How it works
* usage : `bash index1.sh`

This tool requires you to manually acquire your preferred ASN (https://bgp.he.net/) and fill in the inputs. The tool then extracts IP ranges, performs an Nmap scan on live hosts, and finally performs an Nmap scan on open ports(default is top 100 ports,but you can change it to a 1000 in the code if you want.) on live hosts. The output files are generated based on the user input. 

* my nmap scan took a long time so i used an asn that has only one ip range. but i'd like to see the results for an asn that has lots of IP ranges
-------------------------------------------------------------------
####Process
* User Input (ASN)
* whois/radb (ASN Info)
* IP Ranges Extraction
* Nmap Scan -sn (Live Hosts)
* Nmap Scan -sS (Open Ports) on Live Hosts
* Final Nmap Scan Results
-------------------------------------------------------------------

## indeX2
### How it works
* usage:` bash index2.sh <path/to/subdomains>`

   This tool requires you to enter a command with the path to subdomains (without https://). After the scan is complete, you can choose whether to display only the IPs of subdomains or not. By default, the tool displays both the subdomain name and IP. If you choose to display only the IPs, the host command scans the subdomains and saves the IPs in a file. Then, Nmap scans the IPs for live domains. If you choose not to display only the IPs, the tool displays both the subdomain name and IP. However, if you save the file, Nmap scan cannot be performed.
---------------------------------------------------------------------
####Process
* User inputs command with path to subdomains.
* Host command scans subdomains and gets IPs.
* File is saved with a preferred file name.
* Nmap scans IPs for open ports (top 100 ports but can be changed to 1000).
  -------------------------------------------------------------------

**DISCLAIMER**

This tool is meant for Ethetical use only. I do not condone the use of this tool in any unethetical form what so ever. What every you use the tool for, you use at your own risk.
