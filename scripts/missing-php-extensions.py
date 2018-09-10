#!/usr/bin/env python3

import subprocess

# Two ways to exec a command and capture the output
#subprocess.run(cmd, stdout=subprocess.PIPE).stdout
#subprocess.check_output(cmd).decode("utf-8")


def get_ext(cmd):
    s=subprocess.check_output(cmd).decode("utf-8")
    s.replace('\r','')
    a=s.split()
    return set(a)



#cmd=['php',   '-r', 'print_r(json_encode(get_loaded_extensions()));']

cmd_works  = ['ssh', 'works', 'php',  '-m']
cmd_docker = ['docker', 'exec', '-it', 'phpfpm', 'php',  '-m']

ext_works  = get_ext(cmd_works)
ext_docker = get_ext(cmd_docker)

ext_intersect = ext_works & ext_docker

dif_works = ext_works - ext_docker
dif_docker = ext_docker - ext_works

message = f'''
Difference in installed PHP extensions
between Works server and Docker container.


works = {len(ext_works)} extensions
{sorted(ext_works)}

docker = {len(ext_docker)} extensions
{sorted(ext_docker)}

works & docker = {len(ext_intersect)} extensions
{sorted(ext_intersect)}

works - docker = {len(dif_works)} extensions
{sorted(dif_works)}

docker - works = {len(dif_docker)} extensions
{sorted(dif_docker)}
'''

print(message)





