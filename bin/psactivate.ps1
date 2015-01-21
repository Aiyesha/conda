<#
.SYNOPSIS
Prepend conda environment to path. Deactivates prior environment first.

.USAGE
psactivate envname
#>

param (
	[Parameter(
		Mandatory=$True,
		ValueFromPipeline=$True,
		HelpMessage="Specify the conda environment to activate")]
  [string]$conda_new_env
)

$anaconda_envs = "$(Split-Path $PSScriptRoot -parent)\envs"
$conda_env_path = "$anaconda_envs\$conda_new_env"

If (-Not (Test-Path "$conda_env_path\python.exe"))
{
	echo "No environment named $conda_new_env exists in $anaconda_envs"
	exit
} 

if ($env:CONDA_DEFAULT_ENV)
{
		echo "Deactivating environment $env:CONDA_DEFAULT_ENV"
		$old_conda_env = "$anaconda_envs\$env:CONDA_DEFAULT_ENV"
		$env:PATH = ($env:PATH).replace("$old_conda_env\Scripts;","").replace(
			"$old_conda_env;","")
		$env:CONDA_DEFAULT_ENV = ""
}

$env:CONDA_DEFAULT_ENV = $conda_new_env
echo "Activating environment $env:CONDA_DEFAULT_ENV"
$env:PATH = "$conda_env_path;$conda_env_path\Scripts;$env:PATH"

function global:prompt
{
	"[$env:CONDA_DEFAULT_ENV] $PWD>"
}
