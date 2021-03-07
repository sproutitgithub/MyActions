$CredsUname = "sid\djoin"
$CredsPwd = "Pa55w0rd" | ConvertTo-SecureString -AsPlainText -Force 
$Seccreds = New-Object System.Management.Automation.PSCredential -ArgumentList $CredsUname,$CredsPwd
Write-verbose "Testing to see whether i can start a service"
Invoke-Command -ComputerName DC18 -Credential $Seccreds {
$Srv = get-service "AGPM Service"
foreach ($item in $Srv) {
    $Srv.start()
    $Srv1 = get-service "AGPM Service"
    IF (get-service $Srv1.Name | ? {$_.Status -match 'Running'})
    {
        Write-verbose "BITS is up and running!"
    }
    else {
        Write-warning "BITS isnt up and running!"
    }
}

}