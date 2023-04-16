# LISTAR PERMISSÕES EM PASTAS

$pasta = "\\Server\compartilhamneto"
Get-Acl -Path $pasta | Select-Object -ExpandProperty Access |
    Select-Object @{Name=$pasta; Expression={$pasta}}, * | ft -a >> d:\temp\Listagem_permissoes_pasta.txt
