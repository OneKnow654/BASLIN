#!/bin/bash
generate_flags() {
    root_folder="ctf_folder"
    total_folders=20
    selected_folders=5
    hash_folder=".generate_hash"

    # Create the root folder if it doesn't exist
    if [ ! -d "$root_folder" ]; then
        mkdir "$root_folder"
    fi

    # Create the hash folder if it doesn't exist
    if [ ! -d "$hash_folder" ]; then
        mkdir "$hash_folder"
    fi

    # Generate the random folders
    for ((i=1; i<=total_folders; i++))
    do
        folder_name="folder$i"
        
        # Create the folder if it doesn't exist
        if [ ! -d "$root_folder/$folder_name" ]; then
            mkdir "$root_folder/$folder_name"
        fi
    done

    # Select 5 random folders
    selected=()
    while [ ${#selected[@]} -lt $selected_folders ]
    do
        random_number=$((RANDOM % total_folders + 1))
        
        # Check if the folder has already been selected
        if [[ ! " ${selected[@]} " =~ " $random_number " ]]; then
            selected+=($random_number)
        fi
    done

    # Create a file with the flag and hash in each selected folder
    for folder_number in "${selected[@]}"
    do
        folder_name="folder$folder_number"
        flag_file="$root_folder/$folder_name/flag.txt"
        hash_file="$hash_folder/hash.txt"

        # Generate a new random hash for each flag
        random_hash=$(openssl rand -hex 16)
        
        # Create or overwrite the flag file in the selected folder with the hash
        echo "$random_hash" > "$flag_file"

        # Copy the hash to the hash file
        echo "$random_hash" >> "$hash_file"
    done
}

generate_flags
