from setuptools import setup

dependencies = [
    "multidict==5.1.0",  # Avoid 5.2.0 due to Avast
    "aiofiles==0.7.0",  # Async IO for files
    "blspy==1.0.7",  # Signature library
    "chiavdf==1.0.3",  # timelord and vdf verification
    "chiabip158==1.0",  # bip158-style wallet filters
    "chiapos==1.0.6",  # proof of space
    "clvm==0.9.7",
    "clvm_rs==0.1.15",
    "clvm_tools==0.4.3",
    "aiohttp==3.7.4",  # HTTP server for full node rpc
    "aiosqlite==0.17.0",  # asyncio wrapper for sqlite, to store blocks
    "bitstring==3.1.9",  # Binary data management library
    "colorama==0.4.4",  # Colorizes terminal output
    "colorlog==5.0.1",  # Adds color to logs
    "concurrent-log-handler==0.9.19",  # Concurrently log and rotate logs
    "cryptography==3.4.7",  # Python cryptography library for TLS - keyring conflict
    "fasteners==0.16.3",  # For interprocess file locking
    "keyring==23.0.1",  # Store keys in MacOS Keychain, Windows Credential Locker
    "keyrings.cryptfile==1.3.4",  # Secure storage for keys on Linux (Will be replaced)
    #  "keyrings.cryptfile==1.3.8",  # Secure storage for keys on Linux (Will be replaced)
    #  See https://github.com/frispete/keyrings.cryptfile/issues/15
    "PyYAML==5.4.1",  # Used for config file format
    "setproctitle==1.2.2",  # Gives the joker processes readable names
    "sortedcontainers==2.4.0",  # For maintaining sorted mempools
    "websockets==8.1.0",  # For use in wallet RPC and electron UI
    "click==7.1.2",  # For the CLI
    "dnspythonchia==2.2.0",  # Query DNS seeds
    "watchdog==2.1.6",  # Filesystem event watching - watches keyring.yaml
]

upnp_dependencies = [
    "miniupnpc==2.2.2",  # Allows users to open ports on their router
]

dev_dependencies = [
    "pytest",
    "pytest-asyncio",
    "pytest-monitor; sys_platform == 'linux'",
    "pytest-xdist",
    "flake8",
    "mypy",
    "black",
    "aiohttp_cors",  # For blackd
    "ipython",  # For asyncio debugging
    "types-aiofiles",
    "types-click",
    "types-cryptography",
    "types-pkg_resources",
    "types-pyyaml",
    "types-setuptools",
]

kwargs = dict(
    name="joker-blockchain",
    author="Joker",
    author_email="joker@jokercoin.org",
    description="Joker blockchain full node, farmer, timelord, and wallet.",
    url="https://jokercoin.org/",
    license="Apache License",
    python_requires=">=3.7, <4",
    keywords="joker blockchain node",
    install_requires=dependencies,
    setup_requires=["setuptools_scm"],
    extras_require=dict(
        uvloop=["uvloop"],
        dev=dev_dependencies,
        upnp=upnp_dependencies,
    ),
    packages=[
        "build_scripts",
        "joker",
        "joker.cmds",
        "joker.clvm",
        "joker.consensus",
        "joker.daemon",
        "joker.full_node",
        "joker.timelord",
        "joker.farmer",
        "joker.harvester",
        "joker.introducer",
        "joker.plotters",
        "joker.plotting",
        "joker.pools",
        "joker.protocols",
        "joker.rpc",
        "joker.server",
        "joker.simulator",
        "joker.types.blockchain_format",
        "joker.types",
        "joker.util",
        "joker.wallet",
        "joker.wallet.puzzles",
        "joker.wallet.rl_wallet",
        "joker.wallet.cc_wallet",
        "joker.wallet.did_wallet",
        "joker.wallet.settings",
        "joker.wallet.trading",
        "joker.wallet.util",
        "joker.ssl",
        "mozilla-ca",
    ],
    entry_points={
        "console_scripts": [
            "joker = joker.cmds.joker:main",
            "joker_wallet = joker.server.start_wallet:main",
            "joker_full_node = joker.server.start_full_node:main",
            "joker_harvester = joker.server.start_harvester:main",
            "joker_farmer = joker.server.start_farmer:main",
            "joker_introducer = joker.server.start_introducer:main",
            "joker_timelord = joker.server.start_timelord:main",
            "joker_timelord_launcher = joker.timelord.timelord_launcher:main",
            "joker_full_node_simulator = joker.simulator.start_simulator:main",
        ]
    },
    package_data={
        "joker": ["pyinstaller.spec"],
        "": ["*.clvm", "*.clvm.hex", "*.clib", "*.clinc", "*.clsp", "py.typed"],
        "joker.util": ["initial-*.yaml", "english.txt"],
        "joker.ssl": ["joker_ca.crt", "joker_ca.key", "dst_root_ca.pem"],
        "mozilla-ca": ["cacert.pem"],
    },
    use_scm_version={"fallback_version": "unknown-no-.git-directory"},
    long_description=open("README.md", encoding='UTF-8').read(),
    long_description_content_type="text/markdown",
    zip_safe=False,
)


if __name__ == "__main__":
    setup(**kwargs)  # type: ignore
