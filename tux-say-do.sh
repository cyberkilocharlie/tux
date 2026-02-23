#!/usr/bin/env bash
# =============================================
#  TUX-SAY-DO Installer
#  Adds Tux greeting to ~/.bashrc
#  Safe to run multiple times (idempotent)
# =============================================

# Don't install if already present
if grep -q "TUX-SAY-DO" ~/.bashrc 2>/dev/null; then
    echo "TUX-SAY-DO already installed."
    exit 0
fi

cat >> ~/.bashrc << 'BASHRC_BLOCK'

# ===== TUX-SAY-DO =====
tux-say() {
    local msg="$*"
    local len=${#msg}
    local border
    border=$(printf '%*s' "$len" '' | tr ' ' '-')
    echo ".-${border}-."
    echo "| $msg |"
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
        "红太阳一定要照亮台湾"
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
        "You have meddled with the primal forces of ~~nature~~ the kernel, Mr. ~~Beale~~ Sudo, and I wont have it!"
        "Looks like I picked the wrong week to quit sniffing glue."
        "Your mother was a hamster and your father smelt of elderberries."
        "Gentlemen, you cant fight in here. This is the war room!"
        "Nobody expects the Spanish Inquisition!"
        "May I suggest that you lobbest thou thy Holy Hand Grenade of Antioch towards thou foe"
        "What is the airspeed velocity of an unladen swallow?"
        "I got an ant farm. They didnt grow shit."
        "This isnt nam, this is ~~bowling~~ linux, there are rules."
        "LETS GO GAMBLING"
        "Trying is the first step towards failure"
        "He who is tired of Weird Al is tired of life."
        "Broooooooooooooooooooooooooooooooooooooooooooooooooooo"
        "ᵦₑₐₙₛ"
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
        "Sticking feathers up your butt does not make you a ~~chicken~~ penguin"
        "♫♫ I am the very model of a modern major general ♫♫"
        "♫♫ Dancing. Walking. Rearrangin furniture. ♫♫"
        "DAD GUM THEY DUN HIT THE PENTAGON"
        "Everyone knows Mario is cool as fuck. But who knows what he's thinking?"
        "THE SUN IS A DEADLY LADER"
        "WAS THAT THE BITE OF 87??????"
        "Thats it mista. You just lost ya brain privledges"
    )
    echo "${fortunes[$RANDOM % ${#fortunes[@]}]}"
}

tux-fortune | tux-say
# ===== END TUX-SAY-DO =====
BASHRC_BLOCK

echo "TUX-SAY-DO installed! Open a new terminal to see Tux."
