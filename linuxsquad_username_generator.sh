RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'
BLUE='\033[0;34m'; MAGENTA='\033[0;35m'; CYAN='\033[0;36m'
WHITE='\033[0;37m'; BOLD='\033[1m'; NC='\033[0m'

generate_unique_username() {
    local length="$1"
    local charset="abcdefghijklmnopqrstuvwxyz0123456789"
    local charset_len=${#charset}
    local username=""
    for ((j=1; j<=length; j++)); do
        username+="${charset:RANDOM % charset_len:1}"
    done
    echo "$username"
}

generate_usernames() {
    local platform="$1"
    local length="$2"
    local count="$3"
    local output_file="linuxsquad_${platform,,}_$(date +%Y%m%d_%H%M%S).txt"

    clear
    echo ""
    echo -e "  ${CYAN}████████████████████████████████████████████████████████████████${NC}"
    echo -e "  ${CYAN}█${NC}                                                              ${CYAN}█${NC}"
    echo -e "  ${CYAN}█${NC}  ${RED}${BOLD}LINUXSQUAD${NC} - ${GREEN}${BOLD}USERNAME GENERATOR${NC}                    ${CYAN}█${NC}"
    echo -e "  ${CYAN}█${NC}                                                              ${CYAN}█${NC}"
    echo -e "  ${CYAN}████████████████████████████████████████████████████████████████${NC}"
    echo ""
    echo -e "  ${CYAN}Platform:${NC} ${BOLD}$platform${NC}"
    echo -e "  ${CYAN}Length:${NC}   ${BOLD}$length${NC} characters"
    echo -e "  ${CYAN}Total:${NC}    ${BOLD}$count${NC} unique"
    echo ""

    declare -a all_usernames=()
    declare -A seen_usernames=()
    local total=$count
    local bar_width=50
    local attempts=0
    local max_attempts=$((count * 200))

    printf "\r  ${CYAN}[${NC}"
    for ((b=0; b<bar_width; b++)); do printf "░"; done
    printf "${CYAN}] ${BOLD}%3d%%${NC} (0/%d) Generating..." 0 "$total"

    for ((i=1; i<=count; i++)); do
        local username=""
        while true; do
            username=$(generate_unique_username "$length")
            attempts=$((attempts + 1))

            if [[ -z "${seen_usernames[$username]}" ]]; then
                seen_usernames[$username]=1
                all_usernames+=("$username")
                break
            fi

            if [ "$attempts" -gt "$max_attempts" ]; then
                echo ""
                echo -e "\n  ${RED}${BOLD}✗${NC} UYARI: $max_attempts denemede sadece $i unique bulunabildi."
                echo -e "  ${YELLOW}${BOLD}ℹ${NC} Daha uzun username length dene (su an: $length).${NC}"
                count=$i
                break 2
            fi
        done

        local percent=$(( i * 100 / total ))
        local filled=$(( i * bar_width / total ))
        local empty=$(( bar_width - filled ))

        printf "\r  ${CYAN}[${GREEN}"
        for ((b=0; b<filled; b++)); do printf "█"; done
        printf "${NC}${WHITE}"
        for ((b=0; b<empty; b++)); do printf "░"; done
        printf "${CYAN}] ${BOLD}%3d%%${NC} (%d/%d)" "$percent" "$i" "$total"
    done

    echo ""
    echo ""

    > "$output_file"
    echo "LINUXSQUAD Username Generator" >> "$output_file"
    echo "=============================" >> "$output_file"
    echo "Platform: $platform" >> "$output_file"
    echo "Length: $length characters" >> "$output_file"
    echo "Count: $count (unique)" >> "$output_file"
    echo "Date: $(date)" >> "$output_file"
    echo "=============================" >> "$output_file"
    echo "" >> "$output_file"
    for username in "${all_usernames[@]}"; do
        echo "$username" >> "$output_file"
    done
    echo "" >> "$output_file"
    echo "TOTAL: $count unique usernames" >> "$output_file"

    echo -e "  ${GREEN}${BOLD}================== ALL USERNAMES ==================${NC}"
    echo ""
    local counter=0
    for username in "${all_usernames[@]}"; do
        printf "  ${GREEN}%s${NC}" "$username"
        counter=$((counter + 1))
        if [ $((counter % 4)) -eq 0 ]; then
            echo ""
        else
            printf "     "
        fi
    done
    echo ""
    echo ""
    echo -e "  ${GREEN}${BOLD}==================================================${NC}"
    echo ""
    echo -e "  ${GREEN}${BOLD}✓${NC} Saved: ${WHITE}${BOLD}$output_file${NC}"
    echo ""
    if [ "$attempts" -gt "$count" ]; then
        echo -e "  ${YELLOW}${BOLD}ℹ${NC} Total $attempts attempts, $count unique usernames found."
    fi
    echo ""
    read -p "  Press ENTER to continue... "
}

while true; do
    clear
    echo ""
    echo -e "  ${BLUE}                            .                                      ${NC}"
    echo -e "  ${BLUE}                          .o+\`                                    ${NC}"
    echo -e "  ${BLUE}                         \`ooo/                                    ${NC}"
    echo -e "  ${BLUE}                        \`+oooo:                                   ${NC}"
    echo -e "  ${BLUE}                       \`+oooooo:                                  ${NC}"
    echo -e "  ${BLUE}                       -+oooooo+:                                 ${NC}"
    echo -e "  ${BLUE}                     \`/:-:++oooo+:                                ${NC}"
    echo -e "  ${BLUE}                    \`/++++/+++++++:                               ${NC}"
    echo -e "  ${BLUE}                   \`/++++++++++++++:                              ${NC}"
    echo -e "  ${BLUE}                  \`/+++ooooooooooooo/\`                            ${NC}"
    echo -e "  ${RED}                 ./ooosssso++osssssso+\`                           ${NC}"
    echo -e "  ${RED}                .oossssso-\`\`\`\`/ossssss+\`                          ${NC}"
    echo -e "  ${RED}               -osssssso.      :ssssssso.                         ${NC}"
    echo -e "  ${RED}              :osssssss/        osssso+++.                        ${NC}"
    echo -e "  ${RED}             /ossssssss/        +sssssooo/-                       ${NC}"
    echo -e "  ${RED}            \`/ossssso+/:-        -:/+osssso+-                      ${NC}"
    echo -e "  ${RED}            \`+sso+:-.                  \`.-/+oso:                   ${NC}"
    echo -e "  ${RED}            \`++:.                            \`-/+/                 ${NC}"
    echo -e "  ${RED}            .\`                                  \`/                 ${NC}"
    echo ""
    echo -e "  ${BLUE}${BOLD}█   █ █▄ █ █ █ ▀▄▀${RED}${BOLD}  ▄▀▀ █▀█ █ █ █▀█ █▀▄${NC}"
    echo -e "  ${BLUE}${BOLD}█▄▄ █ █ ▀█ █▄█ █ █${RED}${BOLD}  ▄██ ▀▄█ █▄█ █▀█ █▄▀${NC}"
    echo ""
    echo -e "  ${YELLOW}${BOLD}[01]${NC} TikTok        ${YELLOW}${BOLD}[11]${NC} LinkedIn      ${YELLOW}${BOLD}[21]${NC} GitHub"
    echo -e "  ${YELLOW}${BOLD}[02]${NC} Instagram     ${YELLOW}${BOLD}[12]${NC} WhatsApp      ${YELLOW}${BOLD}[22]${NC} GitLab"
    echo -e "  ${YELLOW}${BOLD}[03]${NC} Discord       ${YELLOW}${BOLD}[13]${NC} Spotify       ${YELLOW}${BOLD}[23]${NC} Patreon"
    echo -e "  ${YELLOW}${BOLD}[04]${NC} X (Twitter)   ${YELLOW}${BOLD}[14]${NC} Steam         ${YELLOW}${BOLD}[24]${NC} Kick"
    echo -e "  ${YELLOW}${BOLD}[05]${NC} YouTube       ${YELLOW}${BOLD}[15]${NC} Twitch        ${YELLOW}${BOLD}[25]${NC} Medium"
    echo -e "  ${YELLOW}${BOLD}[06]${NC} Reddit        ${YELLOW}${BOLD}[16]${NC} Pinterest     ${YELLOW}${BOLD}[26]${NC} Clubhouse"
    echo -e "  ${YELLOW}${BOLD}[07]${NC} Telegram      ${YELLOW}${BOLD}[17]${NC} Snapchat      ${YELLOW}${BOLD}[27]${NC} Threads"
    echo -e "  ${YELLOW}${BOLD}[08]${NC} Facebook      ${YELLOW}${BOLD}[18]${NC} Signal        ${YELLOW}${BOLD}[28]${NC} Mastodon"
    echo -e "  ${YELLOW}${BOLD}[09]${NC} TikTok        ${YELLOW}${BOLD}[19]${NC} WeChat        ${YELLOW}${BOLD}[29]${NC} Behance"
    echo -e "  ${YELLOW}${BOLD}[10]${NC} Pinterest     ${YELLOW}${BOLD}[20]${NC} VK            ${YELLOW}${BOLD}[30]${NC} Dribbble"
    echo ""
    echo -ne "  ${RED}${BOLD}█${NC} Select platform (1-30): "
    read -r platform_choice

    declare -a PLATFORMS=( "TikTok" "Instagram" "Discord" "X (Twitter)" "YouTube" "Reddit" "Telegram" "Facebook" "TikTok" "Pinterest" "LinkedIn" "WhatsApp" "Spotify" "Steam" "Twitch" "Pinterest" "Snapchat" "Signal" "WeChat" "VK" "GitHub" "GitLab" "Patreon" "Kick" "Medium" "Clubhouse" "Threads" "Mastodon" "Behance" "Dribbble" )

    if [[ "$platform_choice" =~ ^[0-9]+$ ]] && [ "$platform_choice" -ge 1 ] && [ "$platform_choice" -le 30 ]; then
        selected="${PLATFORMS[$((platform_choice-1))]}"
        
        clear
        echo ""
        echo -e "  ${CYAN}████████████████████████████████████████████████████████████████${NC}"
        echo -e "  ${CYAN}█${NC}                                                              ${CYAN}█${NC}"
        echo -e "  ${CYAN}█${NC}  ${YELLOW}${BOLD}USERNAME LENGTH${NC}                                            ${CYAN}█${NC}"
        echo -e "  ${CYAN}█${NC}                                                              ${CYAN}█${NC}"
        echo -e "  ${CYAN}████████████████████████████████████████████████████████████████${NC}"
        echo ""
        echo -e "  ${CYAN}Platform:${NC} ${BOLD}$selected${NC}"
        echo ""
        echo -e "  ${WHITE}How many characters?${NC}"
        echo -e "  ${YELLOW}Min: 3  |  Max: 15${NC}"
        echo ""
        echo -ne "  ${RED}${BOLD}█${NC} Length: "
        read -r length
        
        if [[ ! "$length" =~ ^[0-9]+$ ]] || [ "$length" -lt 3 ] || [ "$length" -gt 15 ]; then
            echo -e "\n  ${RED}${BOLD}✗${NC} Invalid! Enter 3-15."
            sleep 1
            continue
        fi

        clear
        echo ""
        echo -e "  ${CYAN}████████████████████████████████████████████████████████████████${NC}"
        echo -e "  ${CYAN}█${NC}                                                              ${CYAN}█${NC}"
        echo -e "  ${CYAN}█${NC}  ${YELLOW}${BOLD}HOW MANY TO GENERATE?${NC}                                       ${CYAN}█${NC}"
        echo -e "  ${CYAN}█${NC}                                                              ${CYAN}█${NC}"
        echo -e "  ${CYAN}████████████████████████████████████████████████████████████████${NC}"
        echo ""
        echo -e "  ${CYAN}Platform:${NC} ${BOLD}$selected${NC}"
        echo -e "  ${CYAN}Length:${NC}   ${BOLD}$length${NC} characters"
        echo ""
        echo -e "  ${WHITE}Enter amount (100-5000)${NC}"
        echo -e "  ${YELLOW}All will be unique, no duplicates!${NC}"
        echo ""
        echo -ne "  ${RED}${BOLD}█${NC} Amount: "
        read -r count
        
        if [[ ! "$count" =~ ^[0-9]+$ ]] || [ "$count" -lt 100 ] || [ "$count" -gt 5000 ]; then
            echo -e "\n  ${RED}${BOLD}✗${NC} Invalid! Enter 100-5000."
            sleep 1
            continue
        fi

        generate_usernames "$selected" "$length" "$count"
    else
        echo -e "\n  ${RED}${BOLD}✗${NC} Invalid choice! Enter 1-30."
        sleep 1
    fi
done
