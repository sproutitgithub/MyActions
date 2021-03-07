Write-verbose "Testing to see whether i can start a service"
$Srv = get-service BITS
foreach ($item in $Srv) {
    $Srv.start()
    $Srv1 = get-service BITS
    IF (get-service $Srv1.status -match 'Running')
    {
        Write-verbose "BITS is up and running!"
    }
    else {
        Write-warning "BITS isnt up and running!"
    }
}