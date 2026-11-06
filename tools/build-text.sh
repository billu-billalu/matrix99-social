#!/usr/bin/env bash
# Usage: bash tools/build-text.sh bio-g12 math-g11 ...   (no args = every book)
# Writes sources/text/<name>.txt with a "=== PAGE n" line before each PDF page.
# PDFs with a text layer use pdftotext; scanned PDFs are OCR'd with Tesseract (slow, ~2-3 s/page).
# Needs: winget install UB-Mannheim.TesseractOCR oschwartz10612.Poppler
cd "$(dirname "$0")/.." || exit 1
P="$LOCALAPPDATA/Microsoft/WinGet/Packages/oschwartz10612.Poppler_Microsoft.Winget.Source_8wekyb3d8bbwe/poppler-25.07.0/Library/bin"
T="/c/Program Files/Tesseract-OCR/tesseract.exe"

names=("$@")
[ ${#names[@]} -eq 0 ] && names=($(ls sources/books/*.pdf | xargs -n1 basename | sed 's/\.pdf$//'))

for name in "${names[@]}"; do
  pdf="sources/books/$name.pdf"
  out="sources/text/$name.txt"
  tmp=$(mktemp -d)
  pages=$("$P/pdfinfo.exe" "$pdf" 2>/dev/null | awk '/^Pages:/{print $2}')
  chars=$("$P/pdftotext.exe" -f 1 -l 40 "$pdf" - 2>/dev/null | wc -c)
  # Some PDFs have a broken font encoding: plenty of "text", but mostly control characters.
  ctrl=$("$P/pdftotext.exe" -f 1 -l 40 "$pdf" - 2>/dev/null | LC_ALL=C tr -cd '--' | wc -c)
  [ "$ctrl" -gt $((chars / 20)) ] && chars=0
  : > "$out"
  for ((i=1; i<=pages; i++)); do
    # leading newline: pdftotext ends each page with a form feed and no newline
    printf '\n=== PAGE %d\n' "$i" >> "$out"
    if [ "$chars" -lt 5000 ]; then
      "$P/pdftoppm.exe" -r 200 -gray -f $i -l $i -singlefile -png "$pdf" "$tmp/p" 2>/dev/null
      "$T" "$tmp/p.png" stdout 2>/dev/null >> "$out"
    else
      "$P/pdftotext.exe" -layout -f $i -l $i "$pdf" - 2>/dev/null >> "$out"
    fi
  done
  rm -rf "$tmp"
  echo "done $name ($pages pages, $([ "$chars" -lt 5000 ] && echo OCR || echo text))"
done
