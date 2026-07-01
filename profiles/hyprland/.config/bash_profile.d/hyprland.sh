if [ "$(tty)" = "/dev/tty1" ] && uwsm check may-start && uwsm select; then
	exec uwsm start default
fi
