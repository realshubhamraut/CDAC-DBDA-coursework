Here’s every command from your notes, formatted in Markdown for easy copy-paste:

## System Information
- `uname` — Print the kernel name  
- `uname -r` — Show the kernel release version  
- `uname -a` — Display all system info (kernel, hostname, architecture, etc.)  
- `uname -s` — Show only the kernel name  
- `uname -v` — Print the kernel version and build details  
- `uname -m` — Display machine hardware architecture  
- `uname -n` — Print the network node hostname  
- `cat /etc/os-release` — Show distribution name, version, and OS ID  
- `hostnamectl` — Display or set hostname and OS metadata  
- `hostname` — Print the system’s hostname  
- `hostname -I` — List all assigned IP addresses  
- `hostname -f` — Show the fully qualified domain name (FQDN)  
- `sudo hostnamectl set-hostname <name>` — Change the system hostname  

## CPU Information
- `lscpu` — Display detailed CPU architecture info  
- `cat /proc/cpuinfo` — Show per-core CPU specifications  
- `nproc` — Print the number of available processing units  
- `sudo dmidecode -t system` — Dump system hardware details via DMI  
- `sudo dmidecode -t processor` — Dump processor info via DMI  
- `sudo dmidecode -t memory` — Dump memory device details via DMI  
- `hwinfo` — List detailed hardware specs (if installed)  

## Memory Information
- `free` — Display total, used, and free memory  
- `free -h` — Same as `free` but in human-readable units  
- `cat /proc/meminfo` — Provide detailed memory and swap stats  
- `vmstat -s` — Summarize memory, swap, and paging statistics  

## Disk & Storage
- `df` — Report disk space usage of mounted filesystems  
- `df -h` — Same as `df` but in human-readable units  
- `lsblk` — List block devices in a tree format  
- `sudo fdisk -l` — Show partition tables of all disks  
- `blkid` — Display UUIDs and filesystem types  
- `mount | column -t` — List all mounted filesystems neatly  
- `du -sh /path/to/dir` — Summarize disk usage of a directory  

## Hardware Listing
- `lspci` — List all PCI devices  
- `lspci -v` — Show verbose PCI device details  
- `lspci -vv` — Show very verbose PCI device details  
- `lsusb` — List all connected USB devices  

## Network Information
- `ip a` (or `ip addr show`) — Show network interfaces and IPs  
- `ifconfig` — Display/configure network interfaces (deprecated)  
- `ip route` — Display the kernel routing table  
- `netstat -r` — Show the routing table (deprecated)  
- `ss -tulnp` — List listening TCP/UDP ports with process info  
- `ping <host>` — Test connectivity via ICMP echo requests  
- `traceroute <dest>` — Trace the network path to a destination  
- `tracepath <dest>` — Same as `traceroute` without root  
- `dig <domain>` — Perform a DNS lookup  
- `nslookup <domain>` — Query DNS records (simpler alternative)  

## System Uptime & Load
- `uptime` — Show system uptime and load averages  
- `top` — Display real-time CPU, memory usage, and processes  
- `htop` — Interactive process viewer (if installed)  
- `vmstat 1 5` — Report system stats every second for five iterations  
- `sar -u 1 5` — Collect CPU usage stats every second for five iterations  
- `dstat` — Versatile real-time resource monitoring  
- `iostat -x 1 5` — Show extended CPU and I/O statistics  
- `mpstat -P ALL 1 5` — Display per-core CPU usage statistics  

## User & Login
- `whoami` — Print the effective username  
- `echo $USER` — Display the current username from environment  
- `users` — List usernames of all logged-in users  
- `w` — Show who is logged in and what they’re doing  
- `who` — Display login sessions and terminals  
- `who -q` — Quickly list names and count of logged-in users  
- `who -r` — Show the current system runlevel  
- `who -a` — Display all available login session details  
- `who -b` — Show the last system boot time  
- `who -H` — Include column headers in `who` output  
- `who -u` — Show idle time of each logged-in user  
- `last` — Show a history of last login sessions  

## Date & Time
- `date` — Display or set the system date/time  
- `date +%Y-%m-%d` — Print date in `YYYY-MM-DD` format  
- `date +%T` — Print time in `HH:MM:SS` format  
- `date -u` — Display date/time in UTC  
- `date -u +'%%Y-%%m-%%d %%H:%%M:%%S'` — UTC date/time in custom format  
- `date +'%A'` — Show the full weekday name  
- `sudo date MMDDhhmmccYY.ss` — Manually set system date/time  
- `sudo date +%%Y%%m%%d%%H%%M.%%S -s 'YYYY-MM-DD hh:mm:ss'` — Set date/time via `-s`  
- `date +"%H:%M:%S"` — Print current time  
- `date +"%A, %B %d, %Y"` — Print date in a human-readable format  

## Calendar
- `cal` — Display the current month’s calendar  
- `ncal` — Alternative calendar view with today highlighted  
- `cal -y` — Show the calendar for the entire year  
- `cal -3` — Show previous, current, and next month  
- `cal -3 <m> <y>` — Show month `<m>` of year `<y>` with neighbors  
- `cal <m> <y>` — Show calendar for month `<m>` in year `<y>`