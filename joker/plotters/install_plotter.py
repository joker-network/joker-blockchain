import os
#from chives.plotters.bladebit import install_bladebit
from joker.plotters.madmax import install_madmax


def install_plotter(plotter, root_path):
    if plotter == "chiapos":
        print("Jokerpos already installed. No action taken.")
        return
    elif plotter == "madmax":
        if not os.path.exists(root_path / "madmax-plotter/build/chia_plot"):
            print("Installing madmax plotter.")
            try:
                install_madmax(root_path)
            except Exception as e:
                print(f"Exception while installing madmax plotter: {e}")
            return
        else:
            print("Madmax plotter already installed.")
            return
    #Move the return here for ease of reading
    print("Unknown plotter. No action taken.")
    return

