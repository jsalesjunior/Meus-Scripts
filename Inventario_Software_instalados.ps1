# Scrip inventário de Sofware instalado

$SoftwaresList = Import-Csv D:\ScriptJS\Arquivos\SoftwareList.csv
# Criar arquivo SoftwareList.csv, Contendo na linha 1, "SoftwareName,Version" e nas linhas seguintes o nome do Software,Versão
# EX:
# SotwareName,Version
# Office,1.0

$Computers = Get-Content D:\ScriptJS\Arquivos\Computers.txt
# Incluir o nome dos servidores em arquivo Computers.txt um abaixo do outro
# Ex:
# Servidor1
# Servidor2
[Array]$SoftwaresInventory = ""

foreach ($Computer in $Computers){
$ComputerSoftwares = Get-WmiObject -Class Win32_Product -ComputerName $Computer -ErrorAction SilentlyContinue
    if ($ComputerSoftwares){
       foreach ($Software in $SoftwaresList){
           $NotInstalled = 0
           $PoShObject = New-Object -TypeName psobject
           foreach ($ComputerSoftware in $ComputerSoftwares){
               if ($ComputerSoftware.Name -eq $Software.SoftwareName){
               $PoShObject | Add-Member -MemberType NoteProperty -Name ComputerName -Value ($Computer) -PassThru | `
               Add-Member -MemberType NoteProperty -Name Software -Value ($ComputerSoftware.Name) -PassThru | `
               Add-Member -MemberType NoteProperty -Name Status -Value ("installed") -PassThru | Out-Null
               $SoftwaresInventory += $PoShObject
               $NotInstalled = 1
           }
        }
        if ($NotInstalled -eq 0){
        $PoShObject | Add-Member -MemberType NoteProperty -Name ComputerName -Value ($Computer) -PassThru | `
        Add-Member -MemberType NoteProperty -Name Software -Value ($ComputerSoftware.Name) -PassThru | `
        Add-Member -MemberType NoteProperty -Name Status -Value ("installed") -PassThru | Out-Null
        $SoftwaresInventory += $PoShObject
        }  
     }
  }
}
if ($SoftwaresInventory) {$softwaresInventory | Sort-Object ComputerName,Software | Export-Csv -Path D:\Temp\SoftwareInventary.csv -NoTypeInformation}
