#!/bin/bash
# Usage: rfc (NUMBER)
# Opens HTML version of RFC overview page in default browser
# Credits: https://bbs.archlinux.org/viewtopic.php?pid=2140065#p2140065
# URLs pattern is https://datatracker.ietf.org/doc/rfc1866/

BASEURL="https://datatracker.ietf.org/doc/rfc"

usage() {
    printf "Usage: rfc (NUMBER)\n\n"
    printf "Opens overview page for the given RFC in the default browser\n"
}

# Check if the argument is a number between 1 and 9999
is_valid_number() {
    [[ $1 =~ ^[1-9][0-9]{0,3}$ ]]
}

if [ $# -eq 0 ] || [ "$1" = "--help" ]; then
    usage
elif is_valid_number "${1}" && [ $# -eq 1 ]; then
    url="${BASEURL}${1}/"
    # Detect the operating system and open the URL in the default browser
    case "$(uname)" in
        "Linux") xdg-open "$url" ;;
        "Darwin") open "$url" ;;
        "CYGWIN"*|"MINGW"*|"MSYS"*) start "$url" ;;
        *) printf "Platform not supported\n" && exit 1 ;;
    esac
else
    printf "Invalid option(s) or argument(s).\n\n"
    usage
    exit 1
fi