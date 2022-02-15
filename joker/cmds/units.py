from typing import Dict

# The rest of the codebase uses mojos everywhere.
# Only use these units for user facing interfaces.
units: Dict[str, int] = {
    "joker": 10 ** 8,  # 1 joker (XJK) is 100,000,000 mojo (100 Millions)
    "mojo": 1,
    "colouredcoin": 10 ** 3,  # 1 coloured coin is 1000 colouredcoin mojos
}
