#!/usr/bin/env bash
# Claude Code status line — mirrors Powerlevel10k lean prompt style

RESET=$'\033[0m'
BLUE=$'\033[34m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
DIM=$'\033[2m'

script_dir="$(cd "$(dirname "$0")" && pwd)"
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
weekly=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Shorten home directory to ~
home="$HOME"
short_dir="${cwd/#$home/\~}"

# Git branch (skip optional locks to avoid contention)
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    dirty=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
    if [ -n "$dirty" ]; then
      git_info=" ${YELLOW}${branch}*${RESET}"
    else
      git_info=" ${GREEN}${branch}${RESET}"
    fi
  fi
fi

# Context window usage
ctx_info=""
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  if [ "$used_int" -ge 80 ]; then
    ctx_info=" ${RED}ctx:${used_int}%${RESET}"
  elif [ "$used_int" -ge 50 ]; then
    ctx_info=" ${YELLOW}ctx:${used_int}%${RESET}"
  else
    ctx_info=" ${DIM}ctx:${used_int}%${RESET}"
  fi
fi

# 5-hour rate limit
five_hour_info=""
if [ -n "$five_hour" ]; then
  fh_int=$(printf '%.0f' "$five_hour")
  if [ "$fh_int" -ge 80 ]; then
    five_hour_info=" ${RED}5h:${fh_int}%${RESET}"
  elif [ "$fh_int" -ge 50 ]; then
    five_hour_info=" ${YELLOW}5h:${fh_int}%${RESET}"
  else
    five_hour_info=" ${DIM}5h:${fh_int}%${RESET}"
  fi
fi

# Weekly usage
weekly_info=""
if [ -n "$weekly" ]; then
  wk_int=$(printf '%.0f' "$weekly")
  if [ "$wk_int" -ge 80 ]; then
    weekly_info=" ${RED}wk:${wk_int}%${RESET}"
  elif [ "$wk_int" -ge 50 ]; then
    weekly_info=" ${YELLOW}wk:${wk_int}%${RESET}"
  else
    weekly_info=" ${DIM}wk:${wk_int}%${RESET}"
  fi
fi

# Effort level from instance settings.json
effort=$(jq -r '.effortLevel // empty' "${script_dir}/settings.json" 2>/dev/null)

# Model + effort display (dimmed)
model_info=""
if [ -n "$model" ]; then
  if [ -n "$effort" ]; then
    model_info=" ${DIM}${model} [${effort}]${RESET}"
  else
    model_info=" ${DIM}${model}${RESET}"
  fi
fi

printf "%s%s%s%s%s%s%s%s\n" "${BLUE}" "$short_dir" "${RESET}" "$git_info" "$ctx_info" "$five_hour_info" "$weekly_info" "$model_info"
