import os
from pathlib import Path

DEFAULT_ROOT_PATH = Path(os.path.expanduser(os.getenv("JOKER_ROOT", "~/.joker/mainnet"))).resolve()

DEFAULT_KEYS_ROOT_PATH = Path(os.path.expanduser(os.getenv("JOKER_KEYS_ROOT", "~/.joker_keys"))).resolve()
