# Monitoramento simples de internet com log diário em CSV
# Ajuste o caminho abaixo conforme desejar

$target = "8.8.8.8"   # Alvo para ping (Google DNS)
$logFolder = "C:\Temp\logs"   # PASTA onde vão ficar os arquivos

# Garante que a pasta exista
if (!(Test-Path $logFolder)) {
    New-Item -ItemType Directory -Path $logFolder -Force | Out-Null
}

while ($true) {
    $date = Get-Date -Format "yyyy-MM-dd"
    $log = Join-Path $logFolder "$date-logMonitor.csv"

    # Cria cabeçalho, se ainda não existir
    if (!(Test-Path $log)) {
        "Timestamp,Status,ResponseTimeMs" | Out-File -FilePath $log -Encoding UTF8
    }

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $ping = Test-Connection -ComputerName $target -Count 1 -ErrorAction SilentlyContinue

    if ($ping) {
        $rtt = $ping.ResponseTime
        "$timestamp,UP,$rtt" | Out-File -FilePath $log -Append -Encoding UTF8
    } else {
        "$timestamp,DOWN," | Out-File -FilePath $log -Append -Encoding UTF8
    }

    Start-Sleep -Seconds 10
}
