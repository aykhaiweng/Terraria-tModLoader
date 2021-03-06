#!/usr/bin/env python3
"""
@DESCRIPTION:   Helper file to update the mods that already exist in the
                mod folder. You might want to change the MOD_FOLDER variable
                if you decided to change where the mods were stored.
@AUTHOR:        Au Yeong Khai Weng <aykhaiweng@gmail.com>
"""
import os, glob
from threading import Thread

DOWNLOAD_URL = "http://javid.ddns.net/tModLoader/download.php?Down=mods/{mod_name}"
MOD_FOLDER = "/.local/share/Terraria/ModLoader/Mods"
WGET_COMMAND = "wget '{url}' -O '{target}' -nv"

def download_mod(mod_name, download_url=DOWNLOAD_URL, mod_folder=MOD_FOLDER):
    """
    Download and replace a mod
    """
    mod_url = download_url.format(mod_name=mod_name)
    os.system(WGET_COMMAND.format(url=mod_url, target=os.path.join(mod_folder, mod_name)))

def main(mod_folder=MOD_FOLDER):
    threads = []

    # Controller for searching for mod files in a predefined
    # mod folder
    search_path = mod_folder
    glob_regex = mod_folder + "/*.tmod"
    mods = glob.glob(glob_regex)

    # Clean the directory names
    for i, _m in enumerate(mods.copy()):
        mods[i] = _m.split('/')[-1]

    print(f"Updating the following mods ({glob_regex}): ")
    for _m in mods:
        print(f"\t{_m}")
    confirm = input("Confirm (y/n)? ")
    if confirm.lower() == "y":
        for i in range(len(mods)):
            process = Thread(target=download_mod, args=[mods[i]])
            process.start()
            threads.append(process)

        for process in threads:
            process.join()
        print("Update complete")
    else:
        print("Update cancelled")


if __name__ == '__main__':
    main()

