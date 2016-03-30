#!/bin/bash
#
# chkconfig: 2345 80 90
# description: {{Component}}
# processname: {{Component}}
#


GOPATH={{GoPath}}
PATH=$PATH:$GOPATH/bin
COMPONENT_HOME={{ComponentHome}}
PID_FILE=/var/run/{{Component}}.pid
QUILT_HOME={{GoPath}}/src/github.com/wolferton/quilt

. /etc/init.d/functions

function find_pid() {
    cat $PID_FILE
}

start() {
    echo -n $"Starting {{Component}}"
    sudo -u {{User}} QUILT_HOME=$QUILT_HOME $GOPATH/bin/{{Component}} -c $COMPONENT_HOME/conf/config.json  >> "{{StdOutLog}}" 2>> "{{StdErrLog}}" &
    echo $! > $PID_FILE
    success
    echo
}

stop() {
    kill_{{Component}}
}

kill_{{Component}}() {
    PID=$(find_pid)

    if [ -n "$PID" ]; then
        echo -n $"Killing {{Component}} ($PID)"
        kill -KILL $PID
        rm $PID_FILE
        success
    else
        echo $"{{Component}} is not running"
        failure
    fi
    echo
}

status_{{Component}}() {
    PID=$(find_pid)

    if [ -n "$PID" ]; then
        echo {{Component}} is running with process $PID
    else
        echo {{Component}} does not seem to be running
    fi
    echo
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    kill)
        kill_{{Component}}
        ;;
    status)
        status_{{Component}}
        ;;
    restart|reload|condrestart)
        stop
        start
        ;;
    *)
        echo $"Usage: $0 {start|stop|restart|reload|status|kill}"
        exit 1
esac
exit 0