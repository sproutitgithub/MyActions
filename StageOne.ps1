$CredsUname = "sid\djoin"
$CredsPwd = "Pa55w0rd" | ConvertTo-SecureString -AsPlainText -Force 
$Seccreds = New-Object System.Management.Automation.PSCredential -ArgumentList $CredsUname,$CredsPwd
Write-verbose "Testing to see whether i can start a service"
Invoke-Command -ComputerName DC18 -Credential $Seccreds {
$Srv = get-service "AGPM Service"
foreach ($item in $Srv) {
    try {
        $Srv.start()    
    }
    catch {
        $Err1 = $Error[0]
        Write-warning $err1 -verbose
    }
    
    $Srv1 = get-service "AGPM Service"
    IF (get-service $Srv1.Name | ? {$_.Status -match 'Running'})
    {
        Write-verbose "AGPM Service is up and running!"
    }
    else {
        Write-warning "AGPM Service isnt up and running!"
    }
}

}