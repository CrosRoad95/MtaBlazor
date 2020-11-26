$resourcePath = $args[0]
$metaXmlPath = $($args[0] + "..\meta.xml")
$filesPath = $resourcePath + "..\wwwroot\"
$files = Get-ChildItem -Recurse -af $filesPath
Set-Location $filesPath

$metaXmlContent = ""

$nl = [Environment]::NewLine

$metaXmlContent = $metaXmlContent + "<meta>" + $nl
$metaXmlContent = $metaXmlContent + "`t<script src='_framework\frameworkClient.lua' type='client'/>" + $nl
$metaXmlContent = $metaXmlContent + "`t<script src='_framework\frameworkServer.lua' type='server'/>" + $nl
for ($i=0; $i -lt $files.Count; $i++) {
	$fileName = $files[$i].fullName
	if (!$fileName.EndsWith('.gz') -and !$fileName.EndsWith('.br'))
	{
		if(!$fileName.EndsWith('.lua'))
		{
			$fileName = (Get-Item $fileName | Resolve-Path -Relative).substring(2)
			$file = "`t<file src='$fileName' />"
			$metaXmlContent = $metaXmlContent + $relativePath + $file + $nl
		}
	}
	else
	{
		Remove-Item $fileName
	}
}
$metaXmlContent = $metaXmlContent + "</meta>"

echo $metaXmlContent | Out-File -encoding ASCII $metaXmlPath

Remove-Item $resourcePath -Recurse
Get-ChildItem -Path ($resourcePath + "..\wwwroot\") -Recurse |  Move-Item -Destination ($resourcePath + "..\")

Remove-Item ($resourcePath + "..\wwwroot")
