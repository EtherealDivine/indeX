# indeX

This is a composition of two tools. `indeX1` & `indeX2`

## indeX1
### How it works
* usage : `bash index1.sh`

This tool requires you to manually acquire your preferred ASN and fill in the inputs. The tool then extracts IP ranges, performs an Nmap scan on live hosts, and finally performs an Nmap scan on open ports(default is top 100 ports,but you can change it to a 1000 in the code if you want.) on live hosts. The output files are generated based on the user input. 

* my nmap scan took a long time so i used an asn that has only one ip range. but i'd like to see the results for an asn that has lots of IP ranges
-------------------------------------------------------------------
* User Input (ASN)
* whois/radb (ASN Info)
* IP Ranges Extraction
* Nmap Scan -sn (Live Hosts)
* Nmap Scan -sS (Open Ports) on Live Hosts
* Final Nmap Scan Results
-------------------------------------------------------------------

## indeX2
### How it works
* usage: bash index2.sh <path/to/subdomains>

This tool requires you to enter a command with the path to subdomains (without https://). After the scan is done, the user can choose between displaying only IPs of subdomains or not (default will display subdomain name and IP).if yes, The host command scans subdomains and gets IPs,saves in a file and then Nmap scans IPs for live domains.
if no, subdomain name and ip is displayed and nmap scan cannot be possible if file is saved.
---------------------------------------------------------------------
user inputs command with path to subdomains 
                    |
                    |
                    V
 host command scans subdomains and gets ips
                    |
                    |
                    V
        file is saved(prefered file name)
                    |
                    |
                    V
Nmap scans ips for open ports(top 100 ports but can be changed 1000)
