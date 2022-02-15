from typing import KeysView, Generator

SERVICES_FOR_GROUP = {
    "all": "joker_harvester joker_timelord_launcher joker_timelord joker_farmer joker_full_node joker_wallet".split(),
    "node": "joker_full_node".split(),
    "harvester": "joker_harvester".split(),
    "farmer": "joker_harvester joker_farmer joker_full_node joker_wallet".split(),
    "farmer-no-wallet": "joker_harvester joker_farmer joker_full_node".split(),
    "farmer-only": "joker_farmer".split(),
    "timelord": "joker_timelord_launcher joker_timelord joker_full_node".split(),
    "timelord-only": "joker_timelord".split(),
    "timelord-launcher-only": "joker_timelord_launcher".split(),
    "wallet": "joker_wallet joker_full_node".split(),
    "wallet-only": "joker_wallet".split(),
    "introducer": "joker_introducer".split(),
    "simulator": "joker_full_node_simulator".split(),
}


def all_groups() -> KeysView[str]:
    return SERVICES_FOR_GROUP.keys()


def services_for_groups(groups) -> Generator[str, None, None]:
    for group in groups:
        for service in SERVICES_FOR_GROUP[group]:
            yield service


def validate_service(service: str) -> bool:
    return any(service in _ for _ in SERVICES_FOR_GROUP.values())
