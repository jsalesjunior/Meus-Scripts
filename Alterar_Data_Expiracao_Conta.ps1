$lstuser= cat D:\temp\Arquivos\User_data.txt
foreach ($item In $lstuser) {
    
    try {
        Set-ADUser $item -AccountExpirationDate 01/02/2023 #-WhatIf
        Get-ADUser $item -Properties * | Select-Object SamAccountName,AccountExpirationDate >> D:\temp\Usuarios_alterados1.txt
       
    }
    catch {
      Set-ADUser $item -AccountExpirationDate 01/01/2023 -Server dominio2.com.br #-WhatIf
      Get-ADUser $item -Properties * -Server dominio2.com.br | Select-Object SamAccountName,AccountExpirationDate >> D:\temp\Usuarios_alterados1.txt
    
      $item  >> D:\temp\Usuarios_nao_encontrados.txt
    }
  }


#EVIDÊNCIA
#$lstuser.Count
<#
$lstuser= cat D:\temp\Arquivos\User_data.txt
foreach ($item In $lstuser) {
 
  Get-ADUser $item -Properties * | Select-Object SamAccountName,AccountExpirationDate
}
#>

