# Salvar a política de execução atual
Write-Host "Salvando a Politica Atual"
Start-Sleep -Seconds 2
$originalExecutionPolicy = Get-ExecutionPolicy

# Definir a política de execução para Bypass
Write-Host "Ativando Politica Bypass"
Start-Sleep -Seconds 2
Set-ExecutionPolicy Bypass -Scope Process -Force

# Verificar se o Chocolatey está instalado
Write-Host "Verificando se Chocolatey esta instalado"
Start-Sleep -Seconds 2
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    # Baixar e instalar o Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Write-Host "Instalando Chocolatey"
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Lista de aplicativos a serem instalados
$apps = @(
    "anydesk.install",
    "winrar",
    "jre8",
    "googlechrome",
    "firefox",
    "teamviewer",
    "adobereader",
    "pdfcreator"
)

# Caminho para o arquivo de log
$logPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'choco_install_log.txt')

# Instalar aplicativos e registrar erros
Write-Host "Instalando aplicativos e registrando erros"
Start-Sleep -Seconds 2
foreach ($app in $apps) {
    try {
        choco install $app -y --force
    } catch {
        Add-Content -Path $logPath -Value "Erro ao instalar ${app}: $_"
    }
}

# Restaurar a política de execução original
Write-Host "Restaurando POLITICA ORIGINAL"
Start-Sleep -Seconds 2
Set-ExecutionPolicy $originalExecutionPolicy -Scope Process -Force

Write-Host "Instalacao concluída"