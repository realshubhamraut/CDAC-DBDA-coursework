#!/usr/bin/env python3
"""
Script to trim a CSV file to keep only the first N rows (including header).
Usage: python trim_csv.py input.csv output.csv [max_rows]
Default max_rows is 800000 (including header row)
"""

import sys
import os

def trim_csv(input_file, output_file, max_rows=800000):
    """
    Trim CSV file to keep only first max_rows lines (including header).
    
    Args:
        input_file: Path to input CSV file
        output_file: Path to output CSV file
        max_rows: Maximum number of rows to keep (including header)
    """
    if not os.path.exists(input_file):
        print(f"Error: Input file '{input_file}' does not exist.")
        return False
    
    # Get file size for progress info
    file_size = os.path.getsize(input_file)
    print(f"Input file: {input_file}")
    print(f"File size: {file_size / (1024**2):.2f} MB")
    
    rows_written = 0
    
    try:
        with open(input_file, 'r', encoding='utf-8') as infile, \
             open(output_file, 'w', encoding='utf-8') as outfile:
            
            for line_num, line in enumerate(infile, 1):
                if line_num <= max_rows:
                    outfile.write(line)
                    rows_written += 1
                    
                    # Progress indicator every 100k rows
                    if line_num % 100000 == 0:
                        print(f"Processing... {line_num:,} rows read")
                else:
                    # Stop reading after max_rows
                    break
        
        print(f"\n✓ Success!")
        print(f"  Rows written: {rows_written:,}")
        print(f"  Output file: {output_file}")
        print(f"  Output size: {os.path.getsize(output_file) / (1024**2):.2f} MB")
        
        # Count total rows in original file (if we stopped early)
        if rows_written == max_rows:
            print(f"\n  Note: Stopped at {max_rows:,} rows. Original file may have more.")
        
        return True
        
    except Exception as e:
        print(f"Error: {e}")
        return False


def main():
    if len(sys.argv) < 3:
        print("Usage: python trim_csv.py <input_file> <output_file> [max_rows]")
        print("Example: python trim_csv.py large.csv trimmed.csv 800000")
        print("\nDefault max_rows: 800,000 (including header)")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    max_rows = int(sys.argv[3]) if len(sys.argv) > 3 else 800000
    
    print(f"Trimming to first {max_rows:,} rows (including header)...")
    trim_csv(input_file, output_file, max_rows)


if __name__ == "__main__":
    main()
