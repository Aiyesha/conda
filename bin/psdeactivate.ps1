<#
Deactivate the current conda environment
#>

$anaconda_envs = "$(Split-Path $PSScriptRoot -parent)\envs"

if ($env:CONDA_DEFAULT_ENV)
{
		echo "Deactivating environment $env:CONDA_DEFAULT_ENV"
		$old_conda_env = "$anaconda_envs\$env:CONDA_DEFAULT_ENV"
		$env:PATH = ($env:PATH).replace("$old_conda_env\Scripts;","").replace(
			"$old_conda_env;","")
		$env:CONDA_DEFAULT_ENV = $null
}

function global:prompt
{
	"PS $PWD>"
}
