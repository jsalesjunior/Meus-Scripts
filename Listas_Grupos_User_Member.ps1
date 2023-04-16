<#
Obter usuários de uma lista .txt e listar os grupos que o usuário é membro.
Exportar para um arquivo .csv.
Author: Joaquim Sales
#>

$users = Get-Content D:\JSM\USUARIOS_GRUPO\Users2.txt
$results =@()
foreach ($user in $users) {
$results += Get-ADUser $user -Properties MemberOf | % {$_.MemberOf | Get-AdGroup | select @{Expression={$user};Label=”Usuário”},Name | sort Name}
}
$results | Export-csv -path D:\JSM\Resultado_User.csv -encoding “unicode” -notypeinformation
