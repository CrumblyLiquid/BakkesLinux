import vdf
import sys
import os
from pathlib import Path

print("Setting new launch options")

steam_path = os.path.expanduser("~/.steam/steam")
if(len(sys.argv) > 1):
    steam_path = sys.argv[1]

userdata = Path(steam_path, "userdata")

# Get first account id
# TODO: Give user the choice to choose accounts
userid = next(os.scandir(userdata)).path

config_path = Path(userid, "config/localconfig.vdf")

with open(config_path, 'r') as config_file:
    config = vdf.load(config_file)

rl_config = config["UserLocalConfigStore"]["Software"]["Valve"]["Steam"]["apps"]["252950"]

if "LaunchOptions" in rl_config:
    print(f"Previous launch options: {rl_config['LaunchOptions']}")

rl_config["LaunchOptions"] = f"\"{str(Path(os.path.dirname(__file__), 'bakkes.sh'))}\" & %command%"

with open(config_path, 'w') as config_file:
    vdf.dump(config, config_file, pretty=True)

print("Launch options set")