Param (
    [string]$userandomain,
    [string]$userpassword

)

Write-verbose "User name is $userandomain and password is $userpassword" -verbose

$CredsUname = "sid\djoin"
$CredsPwd = "Pa55w0rd" | ConvertTo-SecureString -AsPlainText -Force 
$Seccreds = New-Object System.Management.Automation.PSCredential -ArgumentList $CredsUname,$CredsPwd
Write-verbose "Testing to see whether i can start a service"
Invoke-Command -ComputerName DC18 -Credential $Seccreds {
$Srv = get-service "AGPM Service"
foreach ($item in $Srv) {
    try {
        Start-Service $item.name  -PassThru  
    }
    catch {
        $Err1 = $Error[0]
        Write-warning $err1 -verbose
    }
}
    
    $Srv1 = get-service "AGPM Service"
    IF (get-service $Srv1.Name | ? {$_.Status -match 'Running'})
    {
        Write-verbose "AGPM Service is up and running. so stopping!"
        try {
            get-service $Srv1.name | Stop-service -passthru 
        }
        catch {
            $err1 = $Error[0]
            Write-warning "I could not stop AGPM Service" -verbose
        }
    }
    else {
        Write-warning "AGPM Service isnt up and running!"
    }
}

