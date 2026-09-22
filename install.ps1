# ==============================================================================
#  SITE-CLONER INSTALLER (Windows PowerShell)
#  Crafted with care by KAYIM — TRUIX DEV
#  Repository: https://github.com/Kouakou-web-ai/site-cloner
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

# Codes de couleur ANSI (Violet)
$e = [char]27
$VIOLET_LIGHT = "$e[38;5;141m"
$VIOLET_MID   = "$e[38;5;135m"
$VIOLET_DEEP  = "$e[38;5;129m"
$VIOLET_SOFT  = "$e[38;5;147m"
$BOLD_VIOLET  = "$e[1;38;5;135m"
$BOLD_WHITE   = "$e[1;37m"
$GREEN        = "$e[1;32m"
$CYAN         = "$e[38;5;117m"
$RESET        = "$e[0m"

Clear-Host
Write-Host ""
Write-Host ($VIOLET_LIGHT + "  _  __     _ __     _____ __  __ " + $RESET)
Write-Host ($VIOLET_MID   + " | |/ /    / \ \   / /_ _|  \/  |" + $RESET)
Write-Host ($VIOLET_MID   + " | ' /    / _ \ \ / / | || |\/| |" + $RESET)
Write-Host ($VIOLET_DEEP  + " | . \   / ___ \ Y /  | || |  | |" + $RESET)
Write-Host ($VIOLET_DEEP  + " |_|\_\ /_/   \_\_/  |___|_|  |_|" + $RESET)
Write-Host ($VIOLET_SOFT  + "  ===========================================" + $RESET)
Write-Host ($BOLD_VIOLET  + "     [+] TRUIX DEV - SITE CLONER INSTALLER [+]" + $RESET)
Write-Host ($VIOLET_SOFT  + "  ===========================================" + $RESET)
Write-Host ""

# Spinner anime
$spinChars = @('|', '/', '-', '\')
$msg1 = "Detection de l'environnement Claude Code..."
for ($i = 0; $i -lt 12; $i++) {
    $c = $spinChars[$i % $spinChars.Length]
    Write-Host -NoNewline ("`r  " + $VIOLET_LIGHT + $c + $RESET + " " + $msg1)
    Start-Sleep -Milliseconds 60
}
Write-Host ("`r  " + $GREEN + "[OK]" + $RESET + " " + $msg1)

# Barre de progression animee
$msg2 = "Telechargement du skill site-cloner"
$total = 20
for ($i = 1; $i -le $total; $i++) {
    Start-Sleep -Milliseconds 35
    $filled = "=" * $i
    $empty = " " * ($total - $i)
    $percent = [math]::Round(($i / $total) * 100)
    Write-Host -NoNewline ("`r  " + $VIOLET_LIGHT + ">" + $RESET + " " + $msg2 + "... [" + $VIOLET_MID + $filled + $RESET + $empty + "] " + $percent + "%")
}
Write-Host ("`r  " + $GREEN + "[OK]" + $RESET + " " + $msg2 + "... [" + $VIOLET_LIGHT + ("=" * $total) + $RESET + "] 100%")

# Repertoire cible
$userProfile = [System.Environment]::GetFolderPath('UserProfile')
$targetDir = Join-Path $userProfile ".claude\skills\site-cloner"
$targetDisplay = "~/.claude/skills/site-cloner (global)"

# Telechargement et installation
$tempZip = Join-Path $env:TEMP "site-cloner-$([Guid]::NewGuid().ToString('N')).zip"
$tempExtract = Join-Path $env:TEMP "site-cloner-$([Guid]::NewGuid().ToString('N'))"

try {
    if (Test-Path ".\site-cloner\SKILL.md") {
        # Si execute depuis le dossier du repo
        New-Item -ItemType Directory -Force -Path (Split-Path $targetDir -Parent) | Out-Null
        if (Test-Path $targetDir) { Remove-Item -Recurse -Force $targetDir }
        Copy-Item -Recurse -Force ".\site-cloner" $targetDir
    } else {
        # Telechargement depuis GitHub
        $zipUrl = "https://github.com/Kouakou-web-ai/site-cloner/archive/refs/heads/main.zip"
        Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip -UseBasicParsing
        Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force
        
        New-Item -ItemType Directory -Force -Path (Split-Path $targetDir -Parent) | Out-Null
        if (Test-Path $targetDir) { Remove-Item -Recurse -Force $targetDir }
        
        $sourceDir = Join-Path $tempExtract "site-cloner-main\site-cloner"
        Copy-Item -Recurse -Force $sourceDir $targetDir
    }
} finally {
    if (Test-Path $tempZip) { Remove-Item -Force $tempZip -ErrorAction SilentlyContinue }
    if (Test-Path $tempExtract) { Remove-Item -Recurse -Force $tempExtract -ErrorAction SilentlyContinue }
}

Write-Host ("  " + $GREEN + "[OK]" + $RESET + " Installation dans " + $CYAN + $targetDisplay + $RESET)
Write-Host ""

# Boite finale
Write-Host ($VIOLET_MID + "  +--------------------------------------------------------+" + $RESET)
Write-Host ($VIOLET_MID + "  |" + $RESET + "  " + $BOLD_WHITE + "Installation reussie avec succes !" + $RESET + "                 " + $VIOLET_MID + "|" + $RESET)
Write-Host ($VIOLET_MID + "  |" + $RESET + "                                                        " + $VIOLET_MID + "|" + $RESET)
Write-Host ($VIOLET_MID + "  |" + $RESET + "  " + $BOLD_VIOLET + "Auteur  :" + $RESET + " " + $BOLD_WHITE + "KAYIM (TRUIX DEV)" + $RESET + "                           " + $VIOLET_MID + "|" + $RESET)
Write-Host ($VIOLET_MID + "  |" + $RESET + "  " + $BOLD_VIOLET + "Skill   :" + $RESET + " site-cloner v1.0.0                          " + $VIOLET_MID + "|" + $RESET)
Write-Host ($VIOLET_MID + "  |" + $RESET + "  " + $BOLD_VIOLET + "Usage   :" + $RESET + " Tapez " + $CYAN + "/skills" + $RESET + " dans Claude Code pour tester  " + $VIOLET_MID + "|" + $RESET)
Write-Host ($VIOLET_MID + "  +--------------------------------------------------------+" + $RESET)
Write-Host ""
