## Situation

Many packages in a distribution ship with a default configuration that is not considered 'secure'.

Hardening guidelines are available for all major distributions. Each is a little different.
Many configuration suggestions are common-sense among security-conscious administrators, who have to apply more secure configuration using some automation framework after installation.

## PROPOSAL

os-release or machine-info should be amended with a field

    PREFER_HARDENED_CONFIG

If the value is '1' or 'True' or 'yes' a package manager can opt to configure an alternative, more secure default configuration (if avaialble).

E.g. 

According to the 'Securing Debian Manual' [1] the login configuration is configured as
    auth       optional   pam_faildelay.so  delay=3000000
whereas 
    delay=10000000
would provide a more secure default. 

The package 'login' contains the file /etc/pam.d/login. If dpkg (or apt or rpm or pacman or whatever) detected that os-release asks for secure defaults, the alternative /etc/pam.d./login.harden could be made the default. (This file doesn't exist yet, the details are left to the packaging infrastructure or package maintainer.)

The existence of PREFER_HARDENED_CONFIG=1 would allow any distribution to select a more suitable default for use-cases where security is considered more important than convenience.

During initial installation of a distribution, the installation tool could ask how to set this value.
Subsequent package installation could then benefit from the more secure defaults.

PRO:

- allows more secure defaults by default
- hardening solved upstream making plethora of distribution specific hardening guides redundant
- contribution to defense-in-depth
- does not impose any particular security policy
- allows smooth transition towards more secure settings

CON:
- yet another entry for os-release

Alternatives considered:
- We could just keep on performing just as badly as before.

[1] https://www.debian.org/doc/manuals/securing-debian-manual/ch04s11.en.html#id-1.5.14.11] 

## Roadmap

After the proposed field was introduced, the following down-stream changes are possible:

I am using Debian here as an example, but any distro should be able to apply similar changes.

Somewhere in the depth of the package installation logic there must be a point when configuration files are copied to /etc (or elsewhere).
It's not necessary to change that logic. Right after installation of the configuration though there shall be hook that's called that would perform the test for PREFER_HARDENED_CONFIG and if it's desired overwrite the default configuration with the more secure default.

Say, we have package foobar.

foobar is installing a default configuration file and a secure configuration file to 

/usr/share/foobar/etc/foobar.config
/usr/share/foobar/etc/foobar.secure.config

As part of the installation, foobar.config is copied to /etc.

'post-install-hook':
    if PREFER_HARDENED_CONFIG:
        copy /usr/share/foobar/etc/foobar.secure.config to etc, overwriting the previous default
     Done
     
 The remaining problem to be solved is: Is there a way to automatically (by convention) guess the name of the secure configuration.
 
 This could be accomplished by the following convention:
 
 For any file that is copied to /etc:
     if this file matches *.* and there exists a file \1.secure.\2
         copy the secure file instead
 
 This way, there would be zero impact on the packaging configuration. 
 The entire intelligence is in the tooling.
 
