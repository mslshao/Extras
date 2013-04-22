function Get-RedditAlienImage($url, $folder) {
Import-Module BitsTransfer
if (-not (Test-Path $folder)) { md $folder }
$ie = New-Object -COMObject InternetExplorer.Application
$ie.Navigate($url)
while($ie.ReadyState -ne 4) { start-sleep -m 200 }
$sources = $ie.document.getElementsByTagName('img') | Select-Object -ExpandProperty src -First 1
$destinations = $sources | ForEach-Object { "$folder\$($_.Split('/')[-1])" }
$displayname = $url.Split('/')[-1]
$ie.Quit()
Start-BitsTransfer $sources $destinations -Prio High -Display $displayname
}
