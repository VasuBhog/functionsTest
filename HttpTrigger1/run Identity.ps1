using namespace System.Net

# Trigger binding data passed in via param block
param($Request)

# Write to the Azure Functions log stream.
Write-Host "PowerShell function with SQL Output Binding processed a request."

$req_body = @(@{
    name="Cup";
    cost=2;
}, @{
    name="Glasses";
    cost=12;
})

# Assign the value we want to pass to the SQL Output binding. 
# The -Name value corresponds to the name property in the function.json for the binding
Push-OutputBinding -Name products -Value $req_body

# Assign the value to return as the HTTP response. 
# The -Name value matches the name property in the function.json for the binding
Push-OutputBinding -Name response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $req_body
})