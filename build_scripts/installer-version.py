import os
import sys

from setuptools_scm import get_version


# example: 1.0.0
def main():
    windows = len(sys.argv) > 1 and "win" in sys.argv[1]  # Special case windows to 0.1.6225

    scm_full_version = get_version(root="..", relative_to=__file__)
    # scm_full_version = "1.0.5.dev22"
    os.environ["SCM_VERSION"] = scm_full_version

    left_full_version = scm_full_version.split("+")
    version = left_full_version[0].split(".")
    scm_major_version = version[1]
    scm_minor_version = version[0]
    smc_patch_version = version[0]

    major_release_number = scm_major_version
    minor_release_number = scm_minor_version
    patch_version_number = smc_patch_version

    install_release_number = major_release_number + "." + minor_release_number + "." + patch_version_number

    print(str(install_release_number))


if __name__ == "__main__":
    main()
