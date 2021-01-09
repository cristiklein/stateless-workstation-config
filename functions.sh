BOLD=
NOBOLD=
if [ -n "$TERM" ]; then
if which tput > /dev/null; then
    BOLD=$(tput bold)
    NOBOLD=$(tput sgr0)
fi
fi

log()
{
    echo $BOLD">>>" $*$NOBOLD >&2
}
