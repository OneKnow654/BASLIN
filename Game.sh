#!/bin/bash

#This tool is devloped for learn purpose in this you learn
#linux basic command 
#
#It like ctf game here will be give task to solve
#the challage in
#
#
#
#
#
#
#
# older Version 1.0.0
# version="1.1.0"
#version="1.2.0"
version="1.2.1"


#-----color-code----\
#---'---fg-----'
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'l
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'
off='\e[0m'
#----bg---'
bgBlack='\033[0;40m'
bgRed='\033[0;41m'
bgGreen='\033[0;42m'
bgYellow='\033[0;43m'
bgBlue='\033[0;44m'
bgPurple='\033[0;45m'
bgCyan='\033[0;46m'
bgWhite='\033[0;47m' 



function banner ()
{
clear

echo -e "\t${Purple} _______   ______   ______  __       ______ __    __  ${off}"
echo -e "\t${Purple}|       \ /      \ /      \|  \     |      \  \  |  \ ${off}"
echo -e "\t${Purple}| ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓      \▓▓▓▓▓▓ ▓▓\ | ▓▓ ${off}"
echo -e "\t${Purple}| ▓▓__/ ▓▓ ▓▓__| ▓▓ ▓▓___\▓▓ ▓▓       | ▓▓ | ▓▓▓\| ▓▓ ${off}"
echo -e "\t${Purple}| ▓▓    ▓▓ ▓▓    ▓▓\▓▓    \| ▓▓       | ▓▓ | ▓▓▓▓\ ▓▓ ${off}"
echo -e "\t${Purple}| ▓▓▓▓▓▓▓\ ▓▓▓▓▓▓▓▓_\▓▓▓▓▓▓\ ▓▓       | ▓▓ | ▓▓\▓▓ ▓▓ ${off}"
echo -e "\t${Purple}| ▓▓__/ ▓▓ ▓▓  | ▓▓  \__| ▓▓ ▓▓_____ _| ▓▓_| ▓▓ \▓▓▓▓ ${off}"
echo -e "\t${Purple}| ▓▓    ▓▓ ▓▓  | ▓▓\▓▓    ▓▓ ▓▓     \   ▓▓ \ ▓▓  \▓▓▓ ${off}"
echo -e "\t${Purple} \▓▓▓▓▓▓▓ \▓▓   \▓▓ \▓▓▓▓▓▓ \▓▓▓▓▓▓▓▓\▓▓▓▓▓▓\▓▓   \▓▓ ${off}"
echo -e "\t${Purple}                                                      ${off}"
echo  -e "\t\t\t\t\t\t${bgBlue}--Made by OneKnown${off}\n\n\t\t\t Version${Red} $version ${off}\n"
echo -e  "${Purple}\t\t\tWelcome to the CTF game!${off}"
echo -e  "${Purple}Your task is to find all the flags and submit them using the 'submit' command.${off}\n"




}

# #validate_flag 
# validate_flag() {
#     file_name="generate_hash/hash.txt"
#     flag="${cmd_args[1]}"
#     valid_flag=false

#     # Read data from file into an array
#     mapfile -t file_data < "$file_name"

#     if [ "${cmd_args[1]}" == "" ]; then
#         echo -e "Please specify a flag.\n"
#     else
#         # Iterate over each line in the file_data array
#         for line in "${file_data[@]}"
#         do
#             # Trim leading and trailing whitespace from each line
#             line=$(echo "$line" | tr -d '[:space:]')

#             if [ "$line" == "$flag" ]; then
#                 valid_flag=true
#                 break
#             fi
#         done

#         if [ "$valid_flag" == true ]; then
#             echo -e "${Blue}Flag submitted successfully!${off}\n"
#         else
#             echo -e "Invalid flag.\n"
#         fi
#     fi
# }
animate_message() {
    local msg="$1"
    local delay=0.1

    echo -ne "${Blue}"

    for ((i = 0; i < ${#msg}; i++)); do
        echo -ne "${msg:$i:1}"
        sleep "$delay"
    done

    echo -e "${off}"
}

count_flags_left() {
    file_name=".generate_hash/hash.txt"
    flag_count=$(wc -l < "$file_name")
    echo "Flags left: $flag_count"
}



validate_flag() {
    file_name=".generate_hash/hash.txt"
    flag="${cmd_args[1]}"
    valid_flag=false

    # Read data from file into an array
    mapfile -t file_data < "$file_name"

    if [ "${cmd_args[1]}" == "" ]; then
        echo -e "Please specify a flag.\n"
    else
        # Create a temporary file to store updated data
        tmp_file=$(mktemp)
        touch "$tmp_file"

        # Iterate over each line in the file_data array
        for line in "${file_data[@]}"
        do
            # Trim leading and trailing whitespace from each line
            line=$(echo "$line" | tr -d '[:space:]')

            if [ "$line" == "$flag" ]; then
                valid_flag=true
            else
                # Append non-matching lines to the temporary file
                echo "$line" >> "$tmp_file"
            fi
        done

        # Replace the original file with the temporary file
        mv "$tmp_file" "$file_name"

        if [ "$valid_flag" == true ]; then
            echo -e "${Blue}Flag submitted successfully!${off}\n"
        else
            echo -e "Invalid flag.\n"
        fi
    fi
}



# Define some variables for the game
flag="FLAG{example_flag}"
directory_prefix="ctf_dir_"
num_directories=10
num_flags=5
allowed_commands=("ls" "cd" "mkdir" "touch" "cat" "submit" "help" "exit" "clear" "quit" "pwd" "rm" "mv" "cp" "banner" "version" "reset" "flagc")

# Define a function to show the help message
show_help() {

    echo ""    
    echo -e  "${Green}----------------------------------------------${off}"
    echo -e  "${Blue}Commands:${off}"
    echo -e  "${Green}  ls                List files and directories${off}"
    echo -e  "${Green}  cd <directory>    Change directory${off}"
    echo -e  "${Green}  mkdir <name>      Create a new directory${off}"
    echo -e  "${Green}  touch <name>      Create a new file${off}"
    echo -e  "${Green}  cat <file>        Print the contents of a file${off}"
    echo -e  "${Green}  submit <flag>     Submit a flag${off}"
    echo -e  "${Green}  mv <src> <des>    Move the file${off}"
    echo -e  "${Green}  cp <src> <des>    Copy a file {off}"
    echo -e  "${Green}  pwd               Show current directory${off}"
    echo -e  "${Green}  help              Show this help message${off}"
    echo -e  "${Green}  clear             Clear the screen${off}"
    echo -e  "${Green}  exit or quit      Exit game${off}"
    echo -e  "${Green}  flagc             Show Remaining flags${off}"
    echo -e  "${Green}  banner            Show banner${off}"
    echo -e  "${Green}  version           Show Version ${off}"
    echo -e  "${Green}  rm                Remove File & Floder ${off}"  
    echo -e  "${Green}  reset             Reset Falgs ${off}"    

    
}

# Define a function to check if a command is allowed
is_command_allowed() {
    for cmd in "${allowed_commands[@]}"; do
        if [ "$cmd" == "$1" ]; then
            return 0
        fi
    done
    return 1
}


run='bash .flaggen.sh'
# Create the directories and flags
function reset(){
folder_name="ctf_folder"
genhash=".generate_hash"

if [ -d "$folder_name" ]; then
    echo -e "${Red}Folder $folder_name exists. Removing...${off}"
    rm -r "$folder_name" "$genhash"
    $run
    echo -e "${bgWhite}${Blue}Now u can continue... playing${off}${off}"
else
    echo "Folder $folder_name does not exist."
    $run
    echo -e "${bgWhite}${Blue}Now u can continue... playing${off}${off}"
fi  
}
#this line generated file and make sure not to generate flag if 
# exist 
function No_repeat(){
    file_name=".generate_hash/hash.txt"
    flag_count=$(wc -l < "$file_name")
    if [ $flag_count -eq 0 ];then
        $run
    else
        clear 
        echo -e "${bgWhite}NOTE: $flag_count flags are remaining ${off} "
        echo -e "${Blue}If you wish a fresh start just type [Y/n]: ${off}"
        read val
        
        case $val in
            [yY] )
                reset
            ;;
            
            [nN] )
            
            animate_message "Game is starting...done"
            
            ;;

            *)
               animate_message "good luck"
            ;;
        esac
        sleep 2
    fi

}

No_repeat



# Start the game loop
current_dir="."
val=0
banner 
while [ $val -eq 0 ]; do
    # Show the prompt and read the command
    #echo -e  "($(whoami)@$(hostname))-[$(basename "$current_dir")]$ "  
    echo -en  "${Green}(${off}${Blue}$(whoami)@$(hostname)${off}${Green})-[${off}$(basename "$current_dir")${Green}]${off}$" 
    read input_command
    # Split the input into command and arguments
IFS=' ' read -ra cmd_args <<< "$input_command"
#cmd_args=($input_command)
# Check if the command is allowed
if ! is_command_allowed "${cmd_args[0]}"; then
    echo -e "${Red}Command not found. Type 'help' for a list of commands.${off}\n"
    continue
fi

# Handle the command
case "${cmd_args[0]}" in
    ls)
        if [ "${cmd_args[1]}" == "-l" ]; then
            ls -l $current_dir
        else
            ls $current_dir

        fi
        echo
        ;;
    cd)
        if [ "${cmd_args[1]}" == "" ]; then
            echo -e"Please specify a directory.\n"

        elif [ "${cmd_args[1]}" == ".." ]; then
            current_dir=$(dirname "$current_dir")
        else
            new_dir="$current_dir/${cmd_args[1]}"
            if [ -d "$new_dir" ]; then
                current_dir="$new_dir"
            else
                echo -e "Directory not found: ${cmd_args[1]}\n"
            fi
        fi
        ;;
    mkdir)
        if [ "${cmd_args[1]}" == "" ]; then
            echo -e "Please specify a directory name.\n"
        else
            if [ -e "$current_dir/${cmd_args[1]}" ]; then
                echo -e "Directory already exists: ${cmd_args[1]}\n"
            else
                mkdir "$current_dir/${cmd_args[1]}"
            fi
        fi
        ;;
    touch)
        if [ "${cmd_args[1]}" == "" ]; then
            echo -e "Please specify a file name.\n"
        else
            if [ -e "$current_dir/${cmd_args[1]}" ]; then
                echo -e "File already exists: ${cmd_args[1]}\n"
            else
                touch "$current_dir/${cmd_args[1]}"
            fi
        fi
        ;;
    cat)
        echo 
        if [ "${cmd_args[1]}" == "" ]; then
            echo -e "Please specify a file name.\n"
        else
            if [ -f "$current_dir/${cmd_args[1]}" ]; then
                cat "$current_dir/${cmd_args[1]}"
            else
                echo -e "File not found: ${cmd_args[1]}\n"
            fi
        fi
        
        ;;
    submit)
        validate_flag
        ;;
    help)
        show_help
        ;;
    clear)
        clear
        ;;
    exit | quit)
         val=1   
        ;;
    pwd)
        echo -e $(pwd | xargs basename )/"$current_dir"
        ;;

    rm)
        if [ "${cmd_args[1]}" == "" ]; then
            echo -e "Please specify a file or directory name.\n"
        else
            # Check if the argument is a file
            if [ -f "$current_dir/${cmd_args[1]}" ]; then
                rm "$current_dir/${cmd_args[1]}"
                echo -e "File ${cmd_args[1]} deleted.\n"
            # Check if the argument is a directory
            elif [ -d "$current_dir/${cmd_args[1]}" ]; then
                rm -r "$current_dir/${cmd_args[1]}"
                echo -e "Directory ${cmd_args[1]} deleted.\n"
            else
                echo -e "File or directory not found: ${cmd_args[1]}\n"
            fi
        fi
    ;;

    banner)  banner ;;
    version) echo -e "${Purple}\n BasLin ${Red}Version $version${off}\n" 
    ;;
    reset)
            reset
    ;;

     flagc) count_flags_left ;;

    mv)
        if [ "${cmd_args[0]}" == "mv" ]; then
            if [ "${cmd_args[1]}" == "" ] || [ "${cmd_args[2]}" == "" ]; then
                echo -e "Please specify a source file and a destination directory.\n"
            else
                # Check if the source file exists
                if [ ! -f "$current_dir/${cmd_args[1]}" ]; then
                    echo -e "Source file not found: ${cmd_args[1]}\n"
                else
                    # Check if the destination directory exists
                    if [ ! -d "$current_dir/${cmd_args[2]}" ]; then
                        echo -e "Destination directory not found: ${cmd_args[2]}\n"
                    else
                        mv "$current_dir/${cmd_args[1]}" "$current_dir/${cmd_args[2]}"
                        echo -e "File ${cmd_args[1]} moved to ${cmd_args[2]}.\n"
                    fi
                fi
            fi
        fi
    ;;

    cp)
        if [ "${cmd_args[0]}" == "cp" ]; then
            if [ "${cmd_args[1]}" == "" ] || [ "${cmd_args[2]}" == "" ]; then
                echo -e "Please specify a source file and a destination directory.\n"
            else
                # Check if the source file exists
                if [ ! -f "$current_dir/${cmd_args[1]}" ]; then
                    echo -e "Source file not found: ${cmd_args[1]}\n"
                else
                    # Check if the destination directory exists
                    if [ ! -d "$current_dir/${cmd_args[2]}" ]; then
                        echo -e "Destination directory not found: ${cmd_args[2]}\n"
                    else
                        mv "$current_dir/${cmd_args[1]}" "$current_dir/${cmd_args[2]}"
                        echo -e "File ${cmd_args[1]} moved to ${cmd_args[2]}.\n"
                    fi
                fi
            fi
        fi
    ;;
    
    
    esac
done
