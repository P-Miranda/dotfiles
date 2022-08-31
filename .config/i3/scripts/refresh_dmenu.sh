#!/usrc/bin/env bash
# refresh dmenu cache
# script based on /usrc/bin/dmenu_path
cachedir=${XDG_CACHE_HOME:-"$HOME/.cache"}
cache=$cachedir/dmenu_run

# create dmenu cache dir if missing
[ ! -e "$cachedir" ] && mkdir -p "$cachedir"

# delete existing dmenu cache
rm -rf $cache

# generate with bash $PATH
IFS=:
stest -flx $PATH | sort -u | tee "$cache"
