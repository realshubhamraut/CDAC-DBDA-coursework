

# 🐧 Complete Linux Command Reference — PG-DBDA Syllabus

This guide provides a comprehensive list of Linux commands essential for system administration, development, and data analysis. It builds upon the initial list by adding more commands, options, and new categories like Process Management and Package Management.

---

## 🔧 System & Hardware Information

Commands to inspect the system's hardware and software configuration.

* **`uname -a`**: Print all system information (kernel name, hostname, kernel release, kernel version, machine architecture, and OS).
* **`uname -s`**: Show the kernel name.
* **`uname -r`**: Show the kernel release version.
* **`uname -m`**: Display the machine's hardware architecture (e.g., x86\_64).
* **`lshw -short`**: Display a summarized tree of all hardware devices.
* **`lscpu`**: Show detailed information about the CPU architecture.
* **`nproc`**: Print the number of processing units available.
* **`cat /proc/cpuinfo`**: Display detailed, low-level CPU information.
* **`cat /proc/meminfo`**: Show detailed statistics about memory usage.
* **`free -h`**: Display free and used memory in a human-readable format (e.g., MB, GB).
* **`lspci -tv`**: Show PCI devices in a tree-like view.
* **`lsusb -tv`**: Display USB devices in a tree-like view.
* **`lsblk`**: List block devices (disks and partitions).
* **`df -h`**: Report file system disk space usage in a human-readable format.
* **`du -sh /path/to/dir`**: Show the total disk usage of a specific directory.
* **`sudo fdisk -l`**: List disk partitions (requires root privileges).
* **`blkid`**: Display block device attributes (UUIDs, filesystem types).
* **`hostname`**: Show the system's current hostname.
* **`hostname -I`**: Display all IP addresses for the host.
* **`hostnamectl`**: Query and change the system hostname and related settings.
* **`cat /etc/os-release`**: Show operating system identification data.
* **`dmesg`**: Print or control the kernel ring buffer (kernel messages).
* **`arch`**: Print machine architecture.
* **`sudo dmidecode`**: Dump DMI (Desktop Management Interface) table contents in a human-readable format.

---

## 👤 User & Group Management

Commands for creating, modifying, and managing user accounts and groups.

* **`whoami`**: Print the effective user ID.
* **`id`**: Display user and group information for the current user.
* **`users`**: Show the usernames of users currently logged in.
* **`who`**: List who is logged on.
* **`w`**: Show who is logged on and what they are doing.
* **`last`**: Display a listing of the last logged-in users.
* **`sudo useradd -m <username>`**: Create a new user with a home directory.
* **`sudo userdel -r <username>`**: Delete a user and their home directory.
* **`sudo usermod -aG <group> <user>`**: Modify a user account, like adding them to a supplementary group.
* **`sudo passwd <username>`**: Change a user's password.
* **`sudo groupadd <groupname>`**: Create a new group.
* **`sudo groupdel <groupname>`**: Delete a group.
* **`su - <user>`**: Switch to a different user account and load their shell environment.
* **`sudo <command>`**: Execute a command as the superuser.
* **`chage -l <username>`**: See a user's password aging information.
* **`groups <username>`**: Print the groups a user is in.

---

## 📁 File & Directory Operations

Essential commands for navigating the filesystem and manipulating files and directories.

* **`pwd`**: Print the name of the current working directory.
* **`cd /path/to/dir`**: Change the current directory.
* **`cd ~`**: Change to the home directory.
* **`cd -`**: Change to the previous directory.
* **`ls`**: List directory contents.
* **`ls -lha`**: List all files (including hidden) with details in a human-readable format.
* **`ls -R`**: List files in subdirectories recursively.
* **`ls -t`**: Sort and list files by modification time, newest first.
* **`touch file.txt`**: Create an empty file or update the modification timestamp of an existing file.
* **`mkdir mydir`**: Create a new directory.
* **`mkdir -p a/b/c`**: Create nested parent directories as needed.
* **`cp source.txt dest.txt`**: Copy a file.
* **`cp -r sourcedir/ destdir/`**: Copy a directory recursively.
* **`mv oldname.txt newname.txt`**: Move or rename a file or directory.
* **`rm file.txt`**: Remove (delete) a file.
* **`rm -rf mydir/`**: Forcefully remove a directory and its contents recursively.
* **`rmdir mydir`**: Remove an empty directory.
* **`ln -s /path/to/target link_name`**: Create a symbolic (soft) link.
* **`ln /path/to/target link_name`**: Create a hard link.
* **`cat file.txt`**: Concatenate and display the content of files.
* **`less file.txt`**: View file content one page at a time (allows backward movement).
* **`more file.txt`**: View file content one page at a time (only allows forward movement).
* **`head -n 20 file.txt`**: Output the first 20 lines of a file.
* **`tail -n 20 file.txt`**: Output the last 20 lines of a file.
* **`tail -f /var/log/syslog`**: "Follow" a file, showing new lines as they are added.
* **`stat file.txt`**: Display file or file system status.
* **`file mydocument`**: Determine the file type.
* **`wc file.txt`**: Print newline, word, and byte counts for a file.
* **`tree`**: List contents of directories in a tree-like format.
* **`readlink link_name`**: Print the value of a symbolic link.

---

## ✏️ Common Text Editors

Commands to create and edit text files directly from the terminal.

* **`nano <filename>`**: A simple, user-friendly command-line text editor, great for beginners.
* **`vi <filename>`** or **`vim <filename>`**: A powerful, modal text editor. Essential commands include `i` (insert mode), `Esc` (command mode), `:w` (write/save), `:q` (quit), and `:wq` (save and quit).
* **`emacs <filename>`**: Another powerful and extensible text editor popular in the developer community.

---

## 🔐 Permissions & Ownership

Commands to control access to files and directories.

* **`chmod 755 script.sh`**: Change file mode bits using octal notation (rwx for owner, r-x for group/others).
* **`chmod u+x script.sh`**: Change file mode bits using symbolic notation (add execute permission for the user/owner).
* **`chmod -R 644 mydir/`**: Recursively change permissions for a directory and its contents.
* **`chown user:group file.txt`**: Change the owner and group of a file.
* **`chown -R user:group mydir/`**: Recursively change ownership for a directory and its contents.
* **`chgrp <group> file.txt`**: Change the group ownership of a file.
* **`umask`**: Display the user file-creation mode mask.
* **`umask 022`**: Set the default permissions for new files (resulting permissions will be 644 for files, 755 for directories).

---

## 🔍 Search, Filters & Text Manipulation

Powerful utilities for finding files and processing text data.

* **`grep "pattern" file.txt`**: Print lines matching a pattern.
* **`grep -ri "pattern" .`**: Recursively and case-insensitively search for a pattern in the current directory.
* **`grep -v "pattern" file.txt`**: Invert the match, showing lines that do not contain the pattern.
* **`find /path -name "*.log"`**: Search for files in a directory hierarchy by name.
* **`find . -type f -mtime -7`**: Find all files in the current directory modified within the last 7 days.
* **`find . -size +100M -exec ls -lh {} \;`**: Find files larger than 100MB and execute `ls -lh` on them.
* **`locate <filename>`**: Find files by name using a pre-built database (very fast).
* **`sudo updatedb`**: Update the `locate` command's database.
* **`which <command>`**: Show the full path of a shell command.
* **`whatis <command>`**: Display single-line manual page descriptions.
* **`apropos <keyword>`**: Search the manual page names and descriptions.
* **`sed 's/old/new/g' file.txt`**: Find and replace text in a file (stream editor).
* **`awk '{print $1, $3}' file.txt`**: A powerful pattern scanning and processing language. This example prints the 1st and 3rd columns.
* **`cut -d',' -f2 file.csv`**: Remove sections from each line of files. This example extracts the 2nd field using a comma delimiter.
* **`sort file.txt`**: Sort lines of text files.
* **`uniq`**: Report or omit repeated lines.
* **`diff file1.txt file2.txt`**: Compare files line by line.
* **`tr 'a-z' 'A-Z' < file.txt`**: Translate or delete characters. This example converts text to uppercase.
* **`xargs`**: Build and execute command lines from standard input.
* **`nl file.txt`**: Number lines of files.

---

## 📊 Process & System Load Management

Commands for monitoring and managing running processes and system performance.

* **`ps aux`**: Report a snapshot of all current processes (BSD syntax).
* **`ps -ef`**: Report a snapshot of all current processes (System V syntax).
* **`ps -eLf`**: Show all processes with their threads.
* **`pstree`**: Display a tree of processes.
* **`top`**: Display a real-time view of running processes and system resources.
* **`htop`**: An interactive process viewer (an improved `top`).
* **`uptime`**: Show how long the system has been running, plus load average.
* **`kill <PID>`**: Send a TERM signal to a process to terminate it gracefully.
* **`kill -9 <PID>`**: Send a KILL signal to forcefully terminate a process.
* **`pkill <process_name>`**: Kill processes by name.
* **`killall <process_name>`**: Kill all processes with a specific name.
* **`jobs`**: List active jobs in the current shell.
* **`bg`**: Place a job in the background.
* **`fg`**: Bring a job to the foreground.
* **`nohup command &`**: Run a command immune to hangups, with output to a "nohup.out" file.
* **`vmstat 1 10`**: Report virtual memory statistics every 1 second for 10 iterations.
* **`iostat -xz 1`**: Report CPU and I/O statistics every second.
* **`sar -u 1 5`**: Collect and display CPU utilization stats every second, 5 times.
* **`nice -n 10 <command>`**: Run a command with a modified scheduling priority.
* **`renice 10 <PID>`**: Alter the priority of a running process.

---

## 🌐 Network & Remote Access

Utilities for network configuration, troubleshooting, and remote system access.

* **`ip addr show`**: Show IP addresses and network interface information (replaces `ifconfig`).
* **`ip route show`**: Show the IP routing table (replaces `netstat -r`).
* **`ip link show`**: Show link-layer information for network devices.
* **`ping <host>`**: Send ICMP ECHO\_REQUEST packets to network hosts.
* **`ss -tuln`**: Display socket statistics (replaces `netstat`). Shows listening TCP and UDP ports without resolving names.
* **`netstat -tuln`**: The older command to show listening ports.
* **`traceroute <host>`**: Print the route packets trace to a network host.
* **`dig <domain>`**: A flexible tool for interrogating DNS name servers.
* **`nslookup <domain>`**: Query Internet name servers interactively.
* **`host <domain>`**: Perform DNS lookups.
* **`whois <domain>`**: Client for the whois directory service.
* **`wget <url>`**: A non-interactive network downloader.
* **`curl <url>`**: Transfer data from or to a server (supports many protocols).
* **`ssh user@host`**: OpenSSH SSH client (remote login program).
* **`scp file.txt user@host:/remote/path`**: Securely copy a file to a remote host.
* **`scp -r dir/ user@host:/remote/path`**: Securely copy a directory recursively.
* **`rsync -avz source/ destination/`**: A fast, versatile remote (and local) file-copying tool.
* **`ftp <hostname>`**: Connect to a host using the File Transfer Protocol.
* **`nmap <host>`**: Network exploration tool and security/port scanner.

---

## 🗜️ Archiving & Compression

Commands for bundling files into archives and reducing their size.

* **`tar -cvf archive.tar dir/`**: Create a `.tar` archive from a directory.
* **`tar -xvf archive.tar`**: Extract files from a `.tar` archive.
* **`tar -tvf archive.tar`**: List the contents of a `.tar` archive.
* **`tar -czvf archive.tar.gz dir/`**: Create a gzip-compressed tar archive.
* **`tar -xzvf archive.tar.gz`**: Extract a gzip-compressed tar archive.
* **`tar -cjvf archive.tar.bz2 dir/`**: Create a bzip2-compressed tar archive.
* **`tar -xjvf archive.tar.bz2`**: Extract a bzip2-compressed tar archive.
* **`gzip file.txt`**: Compress a file (creates `file.txt.gz`).
* **`gunzip file.txt.gz`**: Decompress a gzipped file.
* **`zip -r archive.zip dir/`**: Package and compress files into a zip archive.
* **`unzip archive.zip`**: Extract files from a zip archive.
* **`unzip -l archive.zip`**: List contents of a zip archive without extracting.
* **`bzip2 file.txt`**: Compress a file using bzip2.
* **`bunzip2 file.txt.bz2`**: Decompress a bzip2 file.

---

## 📦 Package Management

Commands to install, update, and remove software packages on different distributions.

### Debian / Ubuntu (apt)
* **`sudo apt update`**: Resynchronize the package index files from their sources.
* **`sudo apt upgrade`**: Install the newest versions of all packages currently installed.
* **`sudo apt install <package_name>`**: Install a new package.
* **`sudo apt remove <package_name>`**: Remove a package.
* **`sudo apt purge <package_name>`**: Remove a package along with its configuration files.
* **`apt search <keyword>`**: Search for a package in the repositories.
* **`apt show <package_name>`**: Show detailed information about a package.
* **`sudo dpkg -i package.deb`**: Install a package from a `.deb` file.

### Red Hat / CentOS / Fedora (yum/dnf)
* **`sudo dnf check-update`**: Check for available package updates.
* **`sudo dnf upgrade`**: Upgrade all packages to their latest versions.
* **`sudo dnf install <package_name>`**: Install a new package.
* **`sudo dnf remove <package_name>`**: Remove a package.
* **`dnf search <keyword>`**: Search for a package.
* **`dnf info <package_name>`**: Show details about a package.
* **`sudo rpm -i package.rpm`**: Install a package from an `.rpm` file.

---

## ⚙️ Service Management (systemd)

Commands to manage system services and daemons.

* **`sudo systemctl start <service>`**: Start a service immediately.
* **`sudo systemctl stop <service>`**: Stop a service immediately.
* **`sudo systemctl restart <service>`**: Stop and then start a service.
* **`sudo systemctl reload <service>`**: Reload a service's configuration without interrupting its operation.
* **`sudo systemctl status <service>`**: Check the current status of a service.
* **`sudo systemctl enable <service>`**: Enable a service to start automatically at boot.
* **`sudo systemctl disable <service>`**: Disable a service from starting at boot.
* **`systemctl list-units --type=service`**: List all running services.
* **`sudo journalctl -u <service>`**: View the logs for a specific service.

---

## 🐚 Shell Scripting & Environment

Commands and concepts central to shell scripting and managing the shell environment.

* **`echo "Hello, World"`**: Display a line of text.
* **`echo $PATH`**: Print the value of an environment variable.
* **`export VAR=value`**: Set an environment variable for the current shell and its child processes.
* **`read <variable_name>`**: Read a line from standard input.
* **`history`**: Display command history.
* **`alias ll='ls -lha'`**: Create an alias (shortcut) for a command.
* **`unalias ll`**: Remove an alias.
* **`man <command>`**: Display the on-line manual page for a command.
* **`clear`**: Clear the terminal screen.
* **`chmod +x script.sh`**: Make a script executable.
* **`./script.sh`**: Execute a script in the current directory.
* **`source script.sh`**: Execute a script in the current shell context.
* **`command > file.txt`**: Redirect standard output, overwriting the file.
* **`command >> file.txt`**: Redirect standard output, appending to the file.
* **`command 2> error.log`**: Redirect standard error.
* **`command &> output.log`**: Redirect both stdout and stderr.
* **`command < file.txt`**: Redirect standard input from a file.
* **`command1 | command2`**: Pipe the output of command1 to the input of command2.
* **`echo $?`**: Display the exit status of the last command (0 means success).
* **`command1 && command2`**: Run command2 only if command1 succeeds.
* **`command1 || command2`**: Run command2 only if command1 fails.
* **`$0, $1, $#`**: Special variables in scripting: script name, first argument, and number of arguments.
* **`exit`**: Exit the shell.

---

## 📅 Date, Time & System Control

Commands for displaying time and controlling the system state.

* **`date`**: Print the current date and time.
* **`date "+%Y-%m-%d %H:%M:%S"`**: Print the date in a custom format.
* **`sudo date -s 'YYYY-MM-DD hh:mm:ss'`**: Set the system date and time.
* **`timedatectl`**: Query and change the system clock and its settings.
* **`cal`**: Display a calendar for the current month.
* **`cal -3`**: Display previous, current, and next month.
* **`cal 2025`**: Display the calendar for the entire year 2025.
* **`shutdown -h now`**: Halt the system immediately.
* **`shutdown -r now`**: Reboot the system now.
* **`reboot`**: A more direct command to reboot the system.
* **`halt`**: A direct command to halt the system.

# 🌐 Advanced SSH & Remote Access Commands

This section expands on the basics of remote access, focusing on the powerful features of SSH for secure and efficient remote administration.

---

## 🔑 SSH Key Management & Passwordless Login

Using SSH keys is more secure and convenient than using passwords. The basic idea is to create a **private key** (which you keep secret on your computer) and a **public key** (which you place on the servers you want to connect to).

* **`ssh-keygen`**: Generates a new SSH key pair.
    * **`ssh-keygen -t ed25519 -C "your_email@example.com"`**: Creates a modern and secure `ed25519` key. You'll be prompted to save the key and set an optional passphrase for extra security.
* **`ssh-copy-id user@host`**: The easiest and most recommended way to install your public key on a remote server. It automatically appends your key to the `~/.ssh/authorized_keys` file on the remote machine with the correct permissions.
* **`ssh-agent`**: A background program that holds your private keys in memory. You "unlock" your key once with its passphrase, and the agent provides it to SSH sessions automatically.
    * **`eval $(ssh-agent -s)`**: Starts the agent for your current shell session.
* **`ssh-add ~/.ssh/id_ed25519`**: Adds your private key to the `ssh-agent`. If you set a passphrase, you'll be prompted to enter it here. After this, you can SSH to any server with your public key without a password or passphrase for the rest of your session.

---

## 🚀 Advanced SSH Usage & Tunneling

SSH can do much more than just give you a shell. It can securely tunnel network traffic.

* **`ssh user@host 'command'`**: Executes a single command on the remote server without starting an interactive shell.
    * *Example*: `ssh admin@webserver 'sudo systemctl restart nginx'`
* **Local Port Forwarding (`-L`)**: Maps a port on your **local machine** to a port on a **remote server**. This is great for securely accessing a remote database or web service that isn't exposed to the internet.
    * *Example*: `ssh -L 8080:localhost:80 user@remoteserver` — Now, visiting `http://localhost:8080` in your local browser will securely connect you to the web server running on port 80 on the `remoteserver`.
* **Remote Port Forwarding (`-R`)**: Maps a port on the **remote server** to a port on your **local machine**. This is useful for temporarily exposing a local development server to the internet through a remote machine.
    * *Example*: `ssh -R 8080:localhost:3000 user@remoteserver` — Anyone visiting `http://remoteserver:8080` will be connected to your local application running on port 3000.
* **Dynamic Port Forwarding / SOCKS Proxy (`-D`)**: Turns the SSH connection into a SOCKS proxy. You can configure your web browser or other applications to route their traffic through this proxy, securely tunneling all your browsing through the remote server.
    * *Example*: `ssh -D 8080 user@remoteserver`
* **SSH Config File (`~/.ssh/config`)**: A configuration file to create shortcuts and aliases for your SSH connections. This is incredibly useful for managing multiple servers.
    ```
    # Example entry in ~/.ssh/config
    Host webserver
        HostName 192.168.1.100
        User admin
        Port 2222
        IdentityFile ~/.ssh/id_webserver
    ```
    With the above config, you can simply type `ssh webserver` instead of the long command.

---

## 📂 Advanced File Transfers

While `scp` is simple, `sftp` and `rsync` offer more power and flexibility.

* **`sftp user@host`**: Starts an interactive **S**ecure **F**ile **T**ransfer **P**rotocol session. It works like a traditional FTP client but runs over the secure SSH protocol. Inside the `sftp` prompt, you can use commands like:
    * **`ls` / `lls`**: List remote / local files.
    * **`cd` / `lcd`**: Change remote / local directory.
    * **`get remote-file`**: Download a file from the server.
    * **`put local-file`**: Upload a file to the server.
* **`rsync` (Advanced Flags)**:
    * **`--delete`**: Deletes files on the destination if they no longer exist at the source. This is used for creating an exact mirror.
    * **`--exclude='*.log'`**: Excludes files matching a certain pattern.

---

## 🖥️ Persistent Remote Sessions (Terminal Multiplexers)

What happens if your internet connection drops during a long remote task? A terminal multiplexer saves your session so you can reconnect later without losing your work.

* **`screen`**: The original terminal multiplexer.
    * **`screen`**: Start a new screen session.
    * **`Ctrl+a` then `d`**: **D**etach from the current session (it keeps running in the background).
    * **`screen -r`**: **R**e-attach to a detached session.
* **`tmux`**: A modern and more popular alternative to `screen`. It has better support for splitting the terminal into multiple panes and managing multiple windows.
    * **`tmux new -s my_session`**: Start a new named session.
    * **`Ctrl+b` then `d`**: **D**etach from the current session.
    * **`tmux attach -t my_session`**: **A**ttach to a named session.

---

## 📱 Alternative Remote Shells

* **`mosh`**: The **Mo**bile **Sh**ell. An alternative to SSH that is designed for unstable or high-latency connections (like mobile or Wi-Fi). It allows you to roam between networks and keeps your session alive even if your connection drops temporarily. It requires `mosh` to be installed on both the client and the server.