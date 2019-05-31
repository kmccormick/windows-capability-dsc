# WindowsCapabilityDsc

There's default DSC resources for WindowsFeature and WindowsOptionalFeature,
but not WindowsCapability.

I want to install OpenSSH Server!

## Using

    Configuration SSH {
        Import-DscResource -ModuleName WindowsCapability
        Node localhost {
            WindowsCapabilityResource sshd {
                Name = "OpenSSH.Server~~~~0.0.1.0"
                Ensure = "Present"
            }
        }
    }
