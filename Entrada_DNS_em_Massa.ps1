# Importar o arquivo .CSV
# No .csv deve conter os campos "name" e "ip" sem o domínio
$dnsEntries = Import-Csv -Path "C:\Temp\dns_entries.csv" -Delimiter ';'

# Loop em cada entrada bi arquivo .CSV
foreach ($entry in $dnsEntries) {
 
    # Adicionar no DNS
    Add-DnsServerResourceRecordA -Name $entry.name -IPv4Address $entry.ip -ZoneName "meudominio.com.br"

}
