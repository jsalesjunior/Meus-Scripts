$servidor = @(
       'ag034_ger01'
       'ag044_ger01'
)
$Total = Get-CimInstance -ComputerName $servidor Win32_PhysicalMemory | Measure-Object -Property capacity -Sum | Foreach {"{0:N2}" -f ([math]::round(($_.Sum / 1GB),2))}
$Disponivel = ((Get-Counter -Counter "\\$servidor\Memory\Available Bytes").CounterSamples.CookedValue | Measure-Object -Sum | Foreach {"{0:N2}" -f ([math]::round(($_.Sum / 1GB),2))})
Write-Host ""
Write-Host "Servidor =" $servidor
Write-Host "Memória Total =" $Total
Write-Host "Memória Disponível ="$Disponivel



# SCRIPT PARA VERIFICAR MEMÓRIA E EXECUTAR AÇÃO DE REMEDIAÇÃO
#$qtd_memory_visivel = Get-WmiObject Win32_OperatingSystem | %{"{0}" -f $_.totalvisiblememorysize/1MB}
#$qtd_Memoria_total = gwmi Win32_OperatingSystem | Measure-Object -Property TotalVisibleMemorySize -Sum | % {[Math]::Round($_.sum/1024/1024)}
$qtd_memory_free = "{0:N2}" -f ((Get-Counter -Counter "\Memory\Available Bytes").CounterSamples.CookedValue / 1GB)

if ($qtd_memory_free -lt 04,80){
    Write-Host "Solução aplicada com sucesso"
}else {
      Write-Host "Abrir incidente"
     #Send-MailMessage -SmtpServer correio.intra.bnb -To destino@correio.intra.bnb -from origem@bnb.gov.br -Subject "Abrir Incidente" -Body "Após execução do script o consumo de memória continua acima do esperado"
 }

"$(get-date -format "yyyy-MM-dd HH:mm:ss"): log line entry" | out-file "c:\temp\log.txt" -Append


