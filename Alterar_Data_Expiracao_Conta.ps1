$lstuser= cat D:\JSM\SCRIPTS\USUARIOS_GRUPO\Arquivos\User_data.txt
foreach ($item In $lstuser) {
    
    try {
        #Set-ADUser $item -AccountExpirationDate 01/01/2023 #-WhatIf
        Get-ADUser $item -Properties * | Select-Object SamAccountName,AccountExpirationDate >> D:\mudanca\Usuarios_alterados1.txt
       
    }
    catch {
      #Set-ADUser $item -AccountExpirationDate 01/01/2023 -Server ag001_ger02 #-WhatIf
      Get-ADUser $item -Properties * -Server ag001_ger02 | Select-Object SamAccountName,AccountExpirationDate >> D:\mudanca\Usuarios_alterados1.txt
    
      #$item  >> D:\mudanca\Usuarios_nao_encontrados.txt
    }
  }


#EVIDÊNCIA
#$lstuser.Count
<#
$lstuser= cat D:\JSM\SCRIPTS\USUARIOS_GRUPO\Arquivos\User_data.txt
foreach ($item In $lstuser) {
 
  Get-ADUser $item -Properties * | Select-Object SamAccountName,AccountExpirationDate
}
#>

