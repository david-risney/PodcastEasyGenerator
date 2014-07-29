param(
	[Parameter(Mandatory=$True, ValueFromPipeline=$True)] [string[]] $XmlInput,
	[Parameter(Mandatory=$True)] [string] $XsltPath);

$XmlInput = $XmlInput -join "`n";

$output = New-Object System.IO.MemoryStream;
$xslt = New-Object System.Xml.Xsl.XslCompiledTransform;
$arglist = New-Object System.Xml.Xsl.XsltArgumentList;
$reader = New-Object System.IO.StreamReader($output);
$xslt.Load($XsltPath);
$xslt.Transform([xml]$XmlInput, $arglist, $output);
$output.position = 0;
 
[string]$reader.ReadToEnd();
$reader.Close();

