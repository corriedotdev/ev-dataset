
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Mobile Safari/537.36"
$response = (Invoke-WebRequest -UseBasicParsing -Uri "https://account.chargeplacescotland.org/api/v2/poi/chargepoint/dynamic" `
-WebSession $session `
-Headers @{
"Accept"="application/json, text/javascript, */*; q=0.01"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="en-US,en;q=0.9"
  "Cache-Control"="no-cache"
  "DNT"="1"
  "Origin"="https://chargeplacescotland.org"
  "Pragma"="no-cache"
  "Referer"="https://chargeplacescotland.org/"
  "Sec-Fetch-Dest"="empty"
  "Sec-Fetch-Mode"="cors"
  "Sec-Fetch-Site"="same-site"
  "api-auth"="c3VwcG9ydCtjcHNhcHBAdmVyc2FudHVzLmNvLnVrOmt5YlRYJkZPJCEzcVBOJHlhMVgj"
  "sec-ch-ua"="`" Not A;Brand`";v=`"99`", `"Chromium`";v=`"100`", `"Google Chrome`";v=`"100`""
  "sec-ch-ua-mobile"="?1"
  "sec-ch-ua-platform"="`"Android`""
}).content

Write-Host "---"
#dynamic-01-02-2022-09-00-00

$dir = "C:\Users\Corrie Green\GitHub\ev-dataset\Dataset\Data\1 week\"
$date = Get-Date -Format "dd-MM-yyyy-HH-mm-00"
$filename = "dynamic-" + $date + ".json"

try {
    [System.IO.File]::WriteAllText($dir+$filename,$response);
} catch {
    Write-Host "Failed to save file"
} 

Write-Host "Done"

