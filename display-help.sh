#!/usr/bin/env bash

set -euo pipefail

display_help() {
    echo "kubectl-mexec - execute/upload/download among pods"
    echo
	echo "Usage:"
    echo "  kubectl mexec [<subcommand>] [-c container_name] [-h] [-p parallel] <kubectl get pod pattern> -- cmd"
    echo
    echo "Commands:"
    echo "  upload             upload local file to multiple pods"
    echo "  download           download files from multiple pods to local"
    echo "  help               show this help message"
    echo
    echo "Parameters:"
    echo "  -c,--container     specify container name"
    echo "  -h,--help          show this help message"
    echo "  -p,--parallel      set concurrent processes, default to 1"
    echo "  -F,--local-file    execute local file on pods"
    echo
    echo "Examples:"
    echo "  # Run 'ls' on every pod with selector 'app.kubernetes.io/name=myapp'"
    echo "  kubectl mexec -l app.kubernetes.io/name=myapp -- ls"
    echo
    echo "  # With parallel 100 pods"
    echo "  kubectl mexec -p 100 -- cmd"
    echo
    echo "  # Run bash script"
    echo '  kubectl mexec -- bash -c "tail -n 10 /etc/passwd | grep root"'
    echo
    echo "  # Run local script file"
    echo "  kubectl mexec -F ./myscript.sh"
    echo
    echo "Homepage:"
    echo "  <https://github.com/major1201/kubectl-mexec>"
}
