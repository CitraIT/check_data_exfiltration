  <#
# Citra IT - Excelência em TI
# Script to test data exfiltration
# Author: luciano@citrait.com.br
# Date: 22/05/2022
# Usage: Powershell -EP ByPass -File Test_Data_Exfiltration.ps1
#>
CLS

Write-Host "#########################################################"
Write-Host "# Running the script to test for a data exfiltration path"
$MY_PATH = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host "Running from: $MY_PATH"
Write-Host "#########################################################"

# .dat file with IP's and ports to test
$data_file_path = "$MY_PATH\data.dat"

# read dat file content into memory
# System.Array[] -> one entry by array index
$RawFileContent = Get-Content -Path $data_file_path

# holdings
$successfull_connections = @()
$unsuccessfull_connections = @()

# parse lines and try connections
ForEach($line in $RawFileContent)
{
    # parse lines
    $target, $ports = $line.split(":")

    # try a connection for each port
    ForEach($target_port in $ports.Split(","))
    {
        $tcp = [System.Net.Sockets.TcpClient]::new()
        # set a timeout, no one can sit here for the whole day...
        $connect = $tcp.BeginConnect($target, $target_port, $null, $null)
        $wait = $connect.AsyncWaitHandle.WaitOne(1000, $false)
        If($tcp.Connected)
        {
            Write-Host -Fore Red "Successfully connected to $target`:$target_port"
            $successfull_connections += "$target`:$target_port"
            $tcp.Close()
        }Else{
            Write-Host -Fore Green "Successfully blocked connection $target`:$target_port"
            $unsuccessfull_connections += "$target`:$target_port"
        }
    }
    
}

# Results
$passed = If($successfull_connections.Count -gt 0){$False}Else{$True}
$passed_message = "Congratulations! You have blocked all tries to data exfiltration."
$not_passed_message = "Sorry, you need to investigate why not all connections where blocked. Try Again!"
Write-Host -Fore Yellow "--------------------------------------"
Write-Host -Fore Yellow "Summary "
Write-Host -Fore Yellow "--------------------------------------"
Write-Host "STATUS: " -NoNewline
If($passed)
{
    Write-Host -Fore Green "Passed!"
    Write-Host -Fore Green $passed_message
}Else{
    Write-Host -Fore Red "Failed!"
    Write-Host -Fore Red $not_passed_message
}
Write-Host "Blocked connections: $($unsuccessfull_connections.Count)"
Write-Host "Successfull connections: $($successfull_connections.Count)"

# show successfull connections
# If($successfull_connections.Count -gt 0)
# {
#     Write-Host "---- LIST OF CONNECTIONS TO CHECK -----"
#     ForEach($conn in $successfull_connections)
#     {
#         Write-Host $conn
#     }
# }




