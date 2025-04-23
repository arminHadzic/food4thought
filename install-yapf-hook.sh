#!/bin/bash
# Auto-install pre-commit git hook for yapf auto-formatting

HOOK_PATH=".git/hooks/pre-commit"
STYLE_FILE=".style.yapf"

# Create style config if missing
if [ ! -f "$STYLE_FILE" ]; then
  echo "Creating default .style.yapf"
  cat <<EOF > "$STYLE_FILE"
[style]
based_on_style = pep8
indent_width = 2
split_before_expression_after_opening_paren = true
EOF
fi

# Install git pre-commit hook
echo "Installing yapf Git pre-commit hook to $HOOK_PATH"
cat <<'HOOK' > "$HOOK_PATH"
#!/bin/bash
echo "🔧 Running YAPF formatter..."

STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.py$')
[ -z "$STAGED_FILES" ] && exit 0

for file in $STAGED_FILES; do
  yapf --in-place --style=.style.yapf "$file"
  git add "$file"
done
HOOK

chmod +x "$HOOK_PATH"
echo "✅ Yapf hook installed. All staged Python files will be auto-formatted before commit."
