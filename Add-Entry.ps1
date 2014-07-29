param(
	$XmlPath,
	$Name,
	$Uri,
	$Date,
	$AudioLength
	);

$effectiveDate = $Date;
$effectiveAudioLength = $AudioLength;

$xml = [xml](gc $xmlPath);
if (!($effectiveDate) -or !($effectiveAudioLength)) {
	$httpResult = wget -Method HEAD $Uri;
	if (!($effectiveDate)) {
		$effectiveDate = $httpResult.Headers["Last-Modified"];
	}
	if (!($effectiveAudioLength)) {
		$effectiveAudioLength = $httpResult.Headers["Content-Length"];
	}
}

$formattedDate = (Get-Date $effectiveDate).GetDateTimeFormats("r");

$entryContainer = $xml.createElement("entryContainer");
$entryContainer.set_InnerXML("<entry name='$name' uri='$uri' length='$effectiveAudioLength' date='$formattedDate'/>");
$xml.podcast.AppendChild($entryContainer.entry);
$xml.podcast.lastUpdated = (Get-Date).GetDateTimeFormats("r");

$xml.outerXML | Out-File $xmlPath -Encoding utf8

