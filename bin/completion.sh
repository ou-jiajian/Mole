#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/core/common.sh"
source "$ROOT_DIR/lib/core/commands.sh"

command_names=()
for entry in "${MOLE_COMMANDS[@]}"; do
    command_names+=("${entry%%:*}")
done
command_words="${command_names[*]}"

emit_zsh_subcommands() {
    for entry in "${MOLE_COMMANDS[@]}"; do
        printf "        '%s:%s'\n" "${entry%%:*}" "${entry#*:}"
    done
}

emit_fish_completions() {
    local cmd="$1"
    for entry in "${MOLE_COMMANDS[@]}"; do
        local name="${entry%%:*}"
        local desc="${entry#*:}"
        printf 'complete -c %s -n "__fish_mole_no_subcommand" -a %s -d "%s"\n' "$cmd" "$name" "$desc"
    done

    printf '\n'
    printf 'complete -c %s -n "not __fish_mole_no_subcommand" -a bash -d "generate bash completion" -n "__fish_see_subcommand_path completion"\n' "$cmd"
    printf 'complete -c %s -n "not __fish_mole_no_subcommand" -a zsh -d "generate zsh completion" -n "__fish_see_subcommand_path completion"\n' "$cmd"
    printf 'complete -c %s -n "not __fish_mole_no_subcommand" -a fish -d "generate fish completion" -n "__fish_see_subcommand_path completion"\n' "$cmd"
}

if [[ $# -gt 0 ]]; then
    normalized_args=()
    for arg in "$@"; do
        case "$arg" in
            "--dry-run" | "-n")
                export MOLE_DRY_RUN=1
                ;;
            *)
                normalized_args+=("$arg")
                ;;
        esac
    done
    if [[ ${#normalized_args[@]} -gt 0 ]]; then
        set -- "${normalized_args[@]}"
    else
        set --
    fi
fi

# Auto-install mode when run without arguments
if [[ $# -eq 0 ]]; then
    if [[ "${MOLE_DRY_RUN:-0}" == "1" ]]; then
        echo -e "${YELLOW}${ICON_DRY_RUN} DRY RUN MODE${NC}，不会修改 shell 配置文件"
        echo ""
    fi

    # Detect current shell
    current_shell="${SHELL##*/}"
    if [[ -z "$current_shell" ]]; then
        current_shell="$(ps -p "$PPID" -o comm= 2> /dev/null | awk '{print $1}')"
    fi

    completion_name=""
    if command -v mole > /dev/null 2>&1; then
        completion_name="mole"
    elif command -v mo > /dev/null 2>&1; then
        completion_name="mo"
    fi

    case "$current_shell" in
        bash)
            config_file="${HOME}/.bashrc"
            [[ -f "${HOME}/.bash_profile" ]] && config_file="${HOME}/.bash_profile"
            # shellcheck disable=SC2016
            completion_line='if output="$('"$completion_name"' completion bash 2>/dev/null)"; then eval "$output"; fi'
            ;;
        zsh)
            config_file="${HOME}/.zshrc"
            # shellcheck disable=SC2016
            completion_line='if output="$('"$completion_name"' completion zsh 2>/dev/null)"; then eval "$output"; fi'
            ;;
        fish)
            config_file="${HOME}/.config/fish/config.fish"
            # shellcheck disable=SC2016
            completion_line='set -l output ('"$completion_name"' completion fish 2>/dev/null); and echo "$output" | source'
            ;;
        *)
            log_error "不支持的 shell：$current_shell"
            echo "  mole completion <bash|zsh|fish>"
            exit 1
            ;;
    esac

    if [[ -z "$completion_name" ]]; then
        if [[ -f "$config_file" ]] && grep -Eq "(^# Mole shell completion$|(mole|mo)[[:space:]]+completion)" "$config_file" 2> /dev/null; then
            if [[ "${MOLE_DRY_RUN:-0}" == "1" ]]; then
                echo -e "${GRAY}${ICON_REVIEW} [DRY RUN] 将从 $config_file 中移除过时的补全配置${NC}"
                echo ""
            else
                original_mode=""
                original_mode="$(stat -f '%Mp%Lp' "$config_file" 2> /dev/null || true)"
                temp_file="$(mktemp)"
                grep -Ev "(^# Mole shell completion$|(mole|mo)[[:space:]]+completion)" "$config_file" > "$temp_file" || true
                mv "$temp_file" "$config_file"
                if [[ -n "$original_mode" ]]; then
                    chmod "$original_mode" "$config_file" 2> /dev/null || true
                fi
                echo -e "${GREEN}${ICON_SUCCESS}${NC} 已从 $config_file 中移除过时的补全配置"
                echo ""
            fi
        fi
        log_error "未在 PATH 中找到 mole，请先安装 Mole 再启用命令补全"
        exit 1
    fi

    # Check if already installed and normalize to latest line
    if [[ -f "$config_file" ]] && grep -Eq "(mole|mo)[[:space:]]+completion" "$config_file" 2> /dev/null; then
        if [[ "${MOLE_DRY_RUN:-0}" == "1" ]]; then
            echo -e "${GRAY}${ICON_REVIEW} [DRY RUN] 将规范化 $config_file 中的补全配置${NC}"
            echo ""
            exit 0
        fi

        original_mode=""
        original_mode="$(stat -f '%Mp%Lp' "$config_file" 2> /dev/null || true)"
        temp_file="$(mktemp)"
        grep -Ev "(^# Mole shell completion$|(mole|mo)[[:space:]]+completion)" "$config_file" > "$temp_file" || true
        mv "$temp_file" "$config_file"
        if [[ -n "$original_mode" ]]; then
            chmod "$original_mode" "$config_file" 2> /dev/null || true
        fi
        {
            echo ""
            echo "# Mole shell 补全"
            echo "$completion_line"
        } >> "$config_file"
        echo ""
        echo -e "${GREEN}${ICON_SUCCESS}${NC} Shell 补全已在 $config_file 中更新"
        echo ""
        exit 0
    fi

    # Prompt user for installation
    echo ""
    echo -e "${GRAY}将添加到 ${config_file}:${NC}"
    echo "  $completion_line"
    echo ""
    if [[ "${MOLE_DRY_RUN:-0}" == "1" ]]; then
        echo -e "${GREEN}${ICON_SUCCESS}${NC} 预览完成，未做任何更改"
        exit 0
    fi

    echo -ne "${PURPLE}${ICON_ARROW}${NC} 为 ${GREEN}${current_shell}${NC} 启用补全？ ${GRAY}回车 确认 / Q 取消${NC}: "
    IFS= read -r -s -n1 key || key=""
    drain_pending_input
    echo ""

    case "$key" in
        $'\e' | [Qq] | [Nn])
            echo -e "${YELLOW}已取消${NC}"
            exit 0
            ;;
        "" | $'\n' | $'\r' | [Yy]) ;;
        *)
            log_error "无效的按键"
            exit 1
            ;;
    esac

    # Create config file if it doesn't exist
    if [[ ! -f "$config_file" ]]; then
        mkdir -p "$(dirname "$config_file")"
        touch "$config_file"
    fi

    # Remove previous Mole completion lines to avoid duplicates
    if [[ -f "$config_file" ]]; then
        original_mode=""
        original_mode="$(stat -f '%Mp%Lp' "$config_file" 2> /dev/null || true)"
        temp_file="$(mktemp)"
        grep -Ev "(^# Mole shell completion$|(mole|mo)[[:space:]]+completion)" "$config_file" > "$temp_file" || true
        mv "$temp_file" "$config_file"
        if [[ -n "$original_mode" ]]; then
            chmod "$original_mode" "$config_file" 2> /dev/null || true
        fi
    fi

    # Add completion line
    {
        echo ""
        echo "# Mole shell 补全"
        echo "$completion_line"
    } >> "$config_file"

    echo -e "${GREEN}${ICON_SUCCESS}${NC} 补全已添加到 $config_file"
    echo ""
    echo ""
    echo -e "${GRAY}现在激活：${NC}"
    echo -e "  ${GREEN}source $config_file${NC}"
    exit 0
fi

case "$1" in
    bash)
        cat << EOF
_mole_completions()
{
    local cur_word prev_word
    cur_word="\${COMP_WORDS[\$COMP_CWORD]}"
    prev_word="\${COMP_WORDS[\$COMP_CWORD-1]}"

    if [ "\$COMP_CWORD" -eq 1 ]; then
        COMPREPLY=( \$(compgen -W "$command_words" -- "\$cur_word") )
    else
        case "\$prev_word" in
            completion)
                COMPREPLY=( \$(compgen -W "bash zsh fish" -- "\$cur_word") )
                ;;
            *)
                COMPREPLY=()
                ;;
        esac
    fi
}

complete -F _mole_completions mole mo
EOF
        ;;
    zsh)
        printf '#compdef mole mo\n\n'
        printf '_mole() {\n'
        printf '    local -a subcommands\n'
        printf '    subcommands=(\n'
        emit_zsh_subcommands
        printf '    )\n'
        printf "    _describe 'subcommand' subcommands\n"
        printf '}\n\n'
        printf 'compdef _mole mole mo\n'
        ;;
    fish)
        printf '# Completions for mole\n'
        emit_fish_completions mole
        printf '\n# Completions for mo (alias)\n'
        emit_fish_completions mo
        printf '\nfunction __fish_mole_no_subcommand\n'
        printf '    for i in (commandline -opc)\n'
        # shellcheck disable=SC2016
        printf '        if contains -- $i %s\n' "$command_words"
        printf '            return 1\n'
        printf '        end\n'
        printf '    end\n'
        printf '    return 0\n'
        printf 'end\n\n'
        printf 'function __fish_see_subcommand_path\n'
        printf '    string match -q -- "completion" (commandline -opc)[1]\n'
        printf 'end\n'
        ;;
    *)
        cat << 'EOF'
Usage: mole completion [bash|zsh|fish]

Setup shell tab completion for mole and mo commands.

Auto-install:
  mole completion              # Auto-detect shell and install
  mole completion --dry-run    # Preview config changes without writing files

Manual install:
  mole completion bash         # Generate bash completion script
  mole completion zsh          # Generate zsh completion script
  mole completion fish         # Generate fish completion script

Examples:
  # Auto-install (recommended)
  mole completion

  # Manual install - Bash
  eval "$(mole completion bash)"

  # Manual install - Zsh
  eval "$(mole completion zsh)"

  # Manual install - Fish
  mole completion fish | source
EOF
        exit 1
        ;;
esac
