Import-Module ActiveDirectory

$DominioDN = (Get-ADDomain).DistinguishedName
$NombreOU = "Empleados_Empresa"
$RutaOU = "OU=$NombreOU,$DominioDN"

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$NombreOU'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $NombreOU -Path $DominioDN
    Write-Host "Unidad Organizativa '$NombreOU' creada." -ForegroundColor Green
}

$Usuarios = Import-Csv -Path "C:\Homelab-AD\scripts\empleados.csv"
$Password = ConvertTo-SecureString "Homelab2026!" -AsPlainText -Force

foreach ($Fila in $Usuarios) {
    $NombreCompleto = "$($Fila.Nombre) $($Fila.Apellido)"
    $SamAccount = $Fila.Usuario
    $UPN = "$SamAccount@$((Get-ADDomain).DNSRoot)"

    if (-not (Get-ADUser -Filter "SamAccountName -eq '$SamAccount'" -ErrorAction SilentlyContinue)) {
        New-ADUser -Name $NombreCompleto `
                   -GivenName $Fila.Nombre `
                   -Surname $Fila.Apellido `
                   -SamAccountName $SamAccount `
                   -UserPrincipalName $UPN `
                   -Department $Fila.Departamento `
                   -Title $Fila.Puesto `
                   -Path $RutaOU `
                   -AccountPassword $Password `
                   -ChangePasswordAtLogon $true `
                   -Enabled $true
        Write-Host "Usuario creado: $NombreCompleto ($SamAccount)" -ForegroundColor Cyan
    } else {
        Write-Host "El usuario $SamAccount ya existe." -ForegroundColor Yellow
    }
}
