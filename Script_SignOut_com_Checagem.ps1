# Scritp para SIGN OUT em usuários com status Desconected dos servidores, consumindo recursos de memória.

$result = query session
$rows = $result -split "`n" 
foreach ($row in $rows) {   
    if ($row -NotMatch "services|console" -and $row -match "Disc") {
        $sessionusername = $row.Substring(19,20).Trim()
        $sessionid = $row.Substring(39,9).Trim()
        Write-Output "Logging Off RDP Disconnected Sessions User $sessionusername"
        logoff $sessionid
    }
}
sleep 20

# Verificar Solução Aplicada:

$qtd_memory_free = "{0:N2}" -f ((Get-Counter -Counter "\Memory\Available Bytes").CounterSamples.CookedValue / 1GB)
if ($qtd_memory_free -lt 4,80){

Write-Host ""
Write-Host "*SOLUÇÃO APLICADA COM SUCESSO*"

}else {
#Send-MailMessage -SmtpServer correio.intra.bnb -To destino@correio.intra.bnb -from origem@bnb.gov.br -Subject "Abrir Incidente" -Body "Após execução do script o consumo de memória continua acima do esperado"
Write-Host "E-MAIL ENVIADO PARA ABERTURA DE INCIDENTE NO SDM"
}