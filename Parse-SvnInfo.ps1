param(
	$Info
)

$table = @{}
foreach ($item in $info) {
	$index = $item.IndexOf(':')
	if ($index -ne -1) {
		$key = $item.Substring(0, $index)
		$value = $item.Substring($index + 2)
		$table.Add($key, $value)
	}
}
$table
