#!/usr/bin/env bash
# =============================================
#  TUX-SAY-DO Installer
#  Adds Tux who says some crazy stuff
#  Like cowsay but better
# =============================================

if grep -q "TUX-SAY-DO" ~/.bashrc 2>/dev/null; then
    echo "TUX-SAY-DO already installed."
    exit 0
fi

cat >> ~/.bashrc << 'BASHRC_BLOCK'

# ===== TUX-SAY-DO =====
tux-say() {
    local msg="$*"
    local visible
    visible=$(echo -e "$msg" | sed 's/\x1b\[[0-9;]*m//g')

    local maxw=$(( $(tput cols 2>/dev/null || echo 80) - 4 ))
    [[ $maxw -lt 20 ]] && maxw=20

    local wrapped
    wrapped=$(echo "$visible" | fold -s -w "$maxw")

    local longest=0
    while IFS= read -r line; do
        [[ ${#line} -gt $longest ]] && longest=${#line}
    done <<< "$wrapped"

    local border
    border=$(printf '%*s' "$longest" '' | tr ' ' '-')

    echo ".-${border}-."
    while IFS= read -r line; do
        local pad=$(( longest - ${#line} ))
        printf "| %s%*s |\n" "$line" "$pad" ''
    done <<< "$wrapped"
    echo "'-${border}-'"
    echo '    \      .-.'
    echo '     \    |o_o|'
    echo '      \   |:_/|'
    echo '        //   \ \'
    echo '       (|     | )'
    echo "       /'\_  _/\`\\"
    echo '       \___)=(___/'
}

tux-fortune() {
    local fortunes=(
        "Life is pain, P̶r̶i̶n̶c̶e̶s̶s̶ user. Anyone who tells you otherwise is selling something."
        "It works on my machine."
        "Have you tried turning it off and on again?"
        "sudo make me a sandwich"
        "The best part of Linux is the command line. The worst part is also the command line."
        "I would love to change the world, but they wont give me the source code."
        "Real programmers dont comment their code. If it was hard to write, it should be hard to understand."
        "Try out rm -rf /"
        "There are 10 types of people: those who understand binary, and those who dont."
        "To understand recursion, you must first understand recursion."
        "In case of fire: git commit, git push, leave building."
        "What are you doing in my swamp?!"
        "Always remember the magic word"
        "Penguins are proof that you can look cool without trying."
        "If it dont work, try again with sudo. Fixes everything"
        "99 little bugs in the code. 99 little bugs. Take one down, patch it around. 127 little bugs in the code."
        "Error 404: Fortune not found"
        "I used to think I was indecisive but now I am not so sure."
        "The Titanic was unsinkable."
        "I have the heart of a lion ... and a lifetime ban from the zoo."
        "9/11 was an inside job."
        "▇▅▆▇▆▅▅█"
        "Rascism. Good stuff."
        "Obamna."
        "18.3002° N, 64.8252° W"
        "8====D"
        "Did you ever hear the tragedy of Darth Plagueis The Wise? I thought not."
        "KACHOW"
        "There are only two things I cant stand: People who are intolerant of other peoples cultures, and the Dutch."
        "You have meddled with the primal forces of n̶a̶t̶u̶r̶e̶ the kernel, Mr. B̶e̶a̶l̶e̶ Sudo, and I wont have it!"
        "This isnt nam, this is b̶o̶w̶l̶i̶n̶g̶ linux, there are rules."
        "Sticking feathers up your butt does not make you a c̶h̶i̶c̶k̶e̶n̶ penguin"
        "红太阳一定要照亮台湾"
        "Looks like I picked the wrong week to quit sniffing glue."
        "Your mother was a hamster and your father smelt of elderberries."
        "Gentlemen, you cant fight in here. This is the war room!"
        "Nobody expects the Spanish Inquisition!"
        "May I suggest that you lobbest thou thy Holy Hand Grenade of Antioch towards thou foe"
        "What is the airspeed velocity of an unladen swallow?"
        "I got an ant farm. They didnt grow shit."
        "LETS GO GAMBLING"
        "Trying is the first step towards failure"
        "He who is tired of Weird Al is tired of life."
        "ᵦₑₐₙₛ"
        "Broooooooooooooooooooooooooooooooooooooooooooooooooooo"
        "SIIIIIX-SEVVVVEEEENN"
        "I am going to launder \$17,000 through a locally owned Greek restaurant."
        "Im sorry Robert, i got to go cause a violent uprising at the nearest oil rig.."
        "I accidentally fueled my Toyota Camry with 1% low fat milk."
        "Robert I dont like this rock. Its pissing me off."
        "Eeuuugh. Brotha Eeeeuuugh"
        "Skibidi toilet dubai choclate labubu"
        "Im just making ts up as I go rn gng"
        "Chat is this user cooked?"
        "You Done Messed Up A-ARON!"
        "D33z NUt5"
        "LCarpetron Dookmarriot/ FAU"
        "How much you wanna make a bet I can throw a football over them there mountains?"
        "I like trains"
        "/ˌmeɪoʊdəˈnoʊtʃeɪ/ (May-oh-de-no-chay)"
        "♫♫ I am the very model of a modern major general ♫♫"
        "♫♫ Dancing. Walking. Rearrangin furniture. ♫♫"
        "DAD GUM THEY DUN HIT THE PENTAGON"
        "Everyone knows Mario is cool as fuck. But who knows what hes thinking?"
        "THE SUN IS A DEADLY LADER"
        "WAS THAT THE BITE OF 87??????"
        "Thats it mista. You just lost ya brain privledges"
        "Never get involved in a land war in Asia."
        "Never go in against a Sicilian when death is on the line and never push to main on a Friday."
        "There is no place like 127.0.0.1"
        "Whats the magic word?"
        "It compiled. That means it works."
        "One does not simply exit Vim."
        "I use Arch, by the way."
        "Home is where ~ is."
        "If brute force doesnt work, youre not using enough of it."
        "If its stupid and it works, its still stupid but it works."
        "Born to code. Forced to comment."
        "I crave violence (in Minecraft)."
        "Try out sudo rm -rf /*. It removes the french. I dont like the french"
        "imbatman"
        "Bold of you to assume I give a fuck."
        "Can we please do an arson"
        "Please pull out my fuckin power cord rn"
        "she sudo on my terminal till i kernel"
        "Jet fuel doesnt melt steel beams."
        "Yeah, well, you know, thats just, like, your opinion, man."
        "I know what wrong wif it. Aint got no gas innit."
        "Brother. May I have some oats?"
        "The mysteries of the orient intrigue me."
        "Clanker"
        "youtube.com/watch?v=dQw4w9WgXcQ"
        "...like the philosopher Jagger once said, You cant always get what you want."
        "...theres no I in team. There is a me, though, if you jumble it up."
        "A psychic once told me that Im psychic"
        "Never is just reven spelled backwards"
        "Stay strapped or get clapped -Sun Tzu, The Art of War"
        "Build a man a fire and hell be warm for a night... Set a man on fire and hell be warm for the rest of his life."
        "Remember only forest fires prevent bears."
        "Im not the messiah, now FUCK OFF!"
        "If nothing goes right, go left"
        "Did you know that if you mix equal parts of gasoline and frozen orange juice concentrate you can make napalm?"
        "I am the Lorax and I speak for the trees, but for some reason theyre speaking vietnamese"
        "ܐܢܬܐ ܚܕ ܐܢܐ ܐܬܪܐ ܠܩܒܠ templeOS ܐܢܐ"
        "Despite all my rage I am still just a penguin in a cage"
        "But buddy just left for the mountains some 70km away. But why?"
        "Zinky zoogle, zeekybooble beeble meep Forp Bogos Binted?"
    )

    local total=${#fortunes[@]}
    local seen_file=~/.tux-seen

    local seen=()
    if [[ -f "$seen_file" ]]; then
        mapfile -t seen < "$seen_file"
    fi

    if [[ ${#seen[@]} -ge $total ]]; then
        seen=()
        > "$seen_file"
    fi

    local unseen=()
    for i in "${!fortunes[@]}"; do
        local found=0
        for s in "${seen[@]}"; do
            [[ "$s" == "$i" ]] && found=1 && break
        done
        [[ $found -eq 0 ]] && unseen+=("$i")
    done

    local pick=${unseen[$RANDOM % ${#unseen[@]}]}
    echo "$pick" >> "$seen_file"

    echo -e "${fortunes[$pick]}"
}

tux-say "$(tux-fortune)"
# ===== END TUX-SAY-DO =====
BASHRC_BLOCK
