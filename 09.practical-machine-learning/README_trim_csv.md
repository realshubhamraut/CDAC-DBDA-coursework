# CSV File Trimming Guide

## Quick Solutions to Keep First 800,000 Rows

### Option 1: Using the Python Script (Recommended)

**Basic usage:**
```bash
python trim_csv.py input.csv output.csv
```

**Specify custom row limit:**
```bash
python trim_csv.py input.csv output.csv 500000
```

**Example with your files:**
```bash
# Trim a specific file
python trim_csv.py "ARCHIVE/module_7_PracticalMachineLearning/PracticalMachineLearning_Assignments CDAC/05.01 twitter_training.csv" "twitter_training_trimmed.csv"
```

### Option 2: Linux Command (head)

**Keep first 800,000 rows (including header = 800,000 lines):**
```bash
head -n 800000 input.csv > output.csv
```

**Example:**
```bash
head -n 800000 "large_file.csv" > "trimmed_file.csv"
```

### Option 3: sed Command (In-place Edit with Backup)

**Create backup and trim original file:**
```bash
sed -i.bak '800001,$ d' yourfile.csv
```
This keeps lines 1-800,000 and deletes everything after.

**Without backup (dangerous - no undo):**
```bash
sed -i '' '800001,$ d' yourfile.csv
```

### Option 4: awk Command

```bash
awk 'NR <= 800000' input.csv > output.csv
```

## Comparison of Methods

| Method | Speed | Safety | Best For |
|--------|-------|--------|----------|
| Python script | Medium | Safe (creates new file) | Large files, progress tracking |
| `head` | Very Fast | Safe (creates new file) | Quick trimming |
| `sed -i.bak` | Fast | Moderate (creates backup) | In-place editing |
| `awk` | Fast | Safe (creates new file) | Custom filtering |

## Check File Line Count

**Before/after trimming:**
```bash
# Quick count (fast)
wc -l yourfile.csv

# Check specific file
wc -l "ARCHIVE/module_7_PracticalMachineLearning/PracticalMachineLearning_Assignments CDAC/05.01 twitter_training.csv"
```

## Safety Tips

1. **Always create a backup first:**
   ```bash
   cp original.csv original.csv.backup
   ```

2. **Test on a small sample:**
   ```bash
   head -n 10 input.csv > test.csv
   ```

3. **Verify output:**
   ```bash
   wc -l output.csv
   head -n 5 output.csv
   tail -n 5 output.csv
   ```

## Finding Large CSV Files

**Find CSV files larger than 100MB:**
```bash
find /Users/proxim/Desktop/CDAC-DBDA-coursework/09.practical-machine-learning -name "*.csv" -size +100M -exec ls -lh {} \;
```

**Count rows in all CSV files:**
```bash
find . -name "*.csv" -exec sh -c 'echo -n "$1: "; wc -l < "$1"' _ {} \;
```

## Examples for Your Workspace

```bash
# Navigate to your directory
cd /Users/proxim/Desktop/CDAC-DBDA-coursework/09.practical-machine-learning

# Find which CSV files are large
find . -name "*.csv" -exec sh -c 'lines=$(wc -l < "$1"); if [ $lines -gt 100000 ]; then echo "$1: $lines lines"; fi' _ {} \;

# Trim using head (fastest)
head -n 800000 "path/to/large.csv" > "path/to/large_trimmed.csv"

# Or use the Python script for progress tracking
python trim_csv.py "path/to/large.csv" "path/to/large_trimmed.csv"
```
