# Purge

## Description

Purge is an anti-forensic tool. Attackers use this tool to cover up their tracks. The system's log files will be modified using anti-forensic techniques.

## The usage

### Timestomp
- -t  Changes the all log files' timestamp.
- -a  Changes the access time of a file.
- -m	Changes the modification time of a file.
- -s	Changes the symbolic link's timestamp of a file.
- -e	Changes the access, modification, and symbolic link's timestamp of a file.
- -v	Print current dates of a file.
- The usage: ./purge.sh [-t]
- The usage: ./purge.sh [-a] [-m] [-s] [-e] [-v] &lt; AbsoluteFilePath &lt;

### Removing
- -z	Delete the file with shredding.
- -k	Delete the all log files with shredding.
- The usage: ./purge.sh [-k]
- The usage: ./purge.sh [-z] <AbsoluteFilePath>
  
### Cleaning
- -l	Clean the all log files.
- -j	Clean the file.
- -c	Clean the all history files.
- The usage: ./purge.sh [-l]
- The usage: $0 [-j] <AbsoluteFilePath>

### Purge
- -x	Do both timestomp and cleaning for log files.
- -u	Shutdown the system.
- The usage: ./purge.sh [-u] [-x]
