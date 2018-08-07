BOLD=
NOBOLD=
if which tput > /dev/null; then
    BOLD=$(tput bold)
    NOBOLD=$(tput sgr0)
fi    
    
log()
{
    echo $BOLD">>>" $*$NOBOLD >&2
}
