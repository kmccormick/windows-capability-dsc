enum Ensure {
	Absent
	Present
}

[DscResource()]
class WindowsCapabilityResource {
	[DscProperty(Key)]
	[string] $Name

	[DscProperty(Mandatory)]
	[Ensure] $Ensure

	[WindowsCapabilityResource] Get() {
		$State = $this.GetState()
		if ($State -eq "Installed") {
			$this.Ensure = [Ensure]::Present
		}
		else {
			$this.Ensure = [Ensure]::Absent
		}
		return $this
	}

	[bool] Test() {
		$State = $this.GetState()

		if ($this.Ensure -eq [Ensure]::Present) {
			return $State -eq "Installed"
		}
		else {
			return $State -eq "NotPresent"
		}
	}

	[void] Set() {
		$State = $this.GetState()

		if ($this.Ensure -eq [Ensure]::Present) {
			if ($State -ne "Installed") {
				Add-WindowsCapability -Online -Name $this.Name
			}
		}
		else {
			if ($State -ne "NotPresent") {
				Remove-WindowsCapability -Online -Name $this.Name
			}
		}
	}

	[string] GetState() {
		return (Get-WindowsCapability -Online -Name $this.Name).State
	}
}
