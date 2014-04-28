
# WHO=$(whoami)
# [ "$WHO" != "michael.vanasse" ] && exec su -c "$0 $*" - michael.vanasse

# EMACS=/usr/local/bin/emacs

# SERVERNAME=elnode
# SOCKETPATH=/tmp/emacs$UID/$SERVERNAME

# case $1 in

#   start)
# 	${EMACS}client -s $SOCKETPATH -e '(print (emacs-version))'
#         if [ $? -ne 0 ] ; then $EMACS --daemon=$SERVERNAME ; fi
# 	;;

#   stop)
# 	${EMACS}client -s $SOCKETPATH -e '(print (emacs-version))'
# 	if [ $? -eq 0 ] ; then ${EMACS}client -s $SOCKETPATH -e '(kill-emacs)' *scratch* ; fi
# 	;;

#   status)
#         if [ ! -S $SOCKETPATH ] ; then exit 1 ; fi
# 	${EMACS}client -s $SOCKETPATH -e '(print (emacs-version))'
# 	;;

# esac

# End }
