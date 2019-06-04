#!/usr/bin/python

from argparse import ArgumentParser
import subprocess
import json

# PARSE ARGUMENTS
parser = ArgumentParser()
parser.add_argument("-s", "--source", type=str, dest="source", default="/var/lib/piserver/os/compunaut-raspi/", help="The source distro to be cloned.")
parser.add_argument("-d", "--dest", type=str, dest="dest", required=True, help="The name of the newly cloned distro.")
args = parser.parse_args()

# DEFINE VARIABLES
source = args.source
dest = "/var/lib/piserver/os/" + args.dest
clone_command = "rsync -avP "+source+" "+dest
installed_dists = "/var/lib/piserver/installed_distros.json"
cmdline_txt_file = dest + "/boot/cmdline.txt"
minion_id_file = dest + "/etc/salt/minion_id"

# COPY DIRECTORY
process = subprocess.Popen(clone_command.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

# UPDATE /boot/cmdline.txt
with open(cmdline_txt_file, 'r') as infile:
  cmdline_txt = infile.read()

cmdline_new = cmdline_txt.replace("compunaut-raspi", args.dest)

with open(cmdline_txt_file, 'w') as outfile:
  outfile.write(cmdline_new)

# UPDATE INSTALLED_DISTROS JSON
with open(installed_dists, 'r') as infile:
  dist_data = json.load(infile)

dist_data.append({"path": dest, "version": "", "name": args.dest})

with open(installed_dists, 'w') as outfile:
  json.dump(dist_data, outfile)

# UPDATE CLONE MINION_ID
with open(minion_id_file, 'w') as outfile:
  outfile.write(args.dest)
