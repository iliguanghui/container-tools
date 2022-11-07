#!/bin/env bash
# 查看两个进程共用的linux名称空间
function ns_diff() {
  proc1=$1
  proc2=$2
  same_ns_list=""
  different_ns_list=""
  for ns in cgroup ipc mnt net pid user uts; do
    t1=$(readlink /proc/$proc1/ns/$ns)
    t2=$(readlink /proc/$proc2/ns/$ns)
    if [ $t1 == $t2 ]; then
      same_ns_list="$same_ns_list $ns"
    else
      different_ns_list="$different_ns_list $ns"
    fi
  done
  echo "$1 and $2 same ns: " "$same_ns_list"
  echo "$1 and $2 different ns: " "$different_ns_list"
}
if [[ "x$1" == "x" || "x$2" == "x" ]]; then exit 1; fi
ns_diff "$1" "$2"
if [ -n "$3" ]; then
  ns_diff "$1" "$3"
  ns_diff "$2" "$3"
fi
