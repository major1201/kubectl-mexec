# kubectl-batch

A fast way to run kubectl exec/cp on multiple pods in parallel.

## Install

### Local install

First make sure you have already installed kubectl.

```bash
# clone this repo
git clone https://github.com/major1201/kubectl-batch.git

# make a link from kubectl-batch to one of your $PATH
ln -s ./kubectl-batch /usr/local/bin/kubectl-batch
```

## Usage

### exec: Batch execute on your pods

```
Usage:
  kubectl batch exec [-c container_name] [-h] [-p parallel] <kubectl get pod pattern> -- cmd

Parameters:
  -c,--container     specify container name
  -h,--help          show this help message
  -p,--parallel      set concurrent processes, default to 1
```

Examples

```bash
# Run 'ls' on every pod with selector 'app.kubernetes.io/name=myapp'
kubectl batch exec -l app.kubernetes.io/name=myapp -- ls

# With parallel 100 pods
kubectl batch exec -p 100 -- cmd

# Run bash script
kubectl batch exec -- bash -c "tail -n 10 /etc/passwd | grep root"
```

### upload: Batch upload local file to your pods

```
Usage:
  kubectl batch upload [-c container_name] [-h] [-p parallel] --local-file <local-file> --remote-path <remote-file-path>

Parameters:
  -h,--help          show this help message
  -c,--container     specify container name
  --retries          set number of retries to complete a copy operation from a container
  -p,--parallel      set concurrent processes, default to 1
  -F,--local-file    local file to upload
  -r,--remote-path   remote path
```

Examples:

```bash
# Upload ./local-file to every pod with label app.kubernetes.io/name=myapp in /tmp/local-file
kubectl batch upload -l app.kubernetes.io/name=myapp --local-file ./local-file --remote-path /tmp/local-file

# Upload file with concurrent 10 processes in parallel
kubectl batch upload -p 10 -l app.kubernetes.io/name=myapp -F ./local-file -r /tmp/local-file
```

### download: Batch download your files in container to your local directory

```
Usage:
  kubectl batch download [-c container_name] [-h] [-p parallel] [--local-directory <local-file>] --remote-path <remote-file-path>

Parameters:
  -h,--help              show this help message
  -c,--container         specify container name
  --retries              set number of retries to complete a copy operation from a container
  -p,--parallel          set concurrent processes, default to 1
  -d,--local-directory   local file to upload
  -r,--remote-path       remote path
```

Examples:

```bash
# Download ./tmp/local-file from every pod with label app.kubernetes.io/name=myapp to pwd with pod name for each pod
kubectl batch download -l app.kubernetes.io/name=myapp --remote-path /tmp/local-file

# Download file with concurrent 10 processes in parallel
kubectl batch download -l app.kubernetes.io/name=myapp --remote-path /tmp/local-file -p 10
```

This'll download your file/directory from container to local directory with pod name for your source file/directory

```bash
$ kubectl batch download -l app.kubernetes.io/name=dancedn --remote-path /tmp/myfile.sh -c my -p 3
mypod-1 tar: Removing leading `/' from member names
mypod-0 tar: Removing leading `/' from member names
mypod-2 tar: Removing leading `/' from member names
$ ls
mypod-0
mypod-1
mypod-2
```
