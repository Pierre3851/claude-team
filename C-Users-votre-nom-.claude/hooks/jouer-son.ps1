# Joue un son Windows. Appele par les hooks de Claude Code.
# Aucun repli silencieux : un son introuvable fait echouer le hook en le disant.
# Journalise l'evenement recu, pour pouvoir constater QUI declenche le son.
param(
    [Parameter(Mandatory = $true)]
    [string]$Son
)

$journal = Join-Path $env:USERPROFILE '.claude\hooks\journal-sons.log'

# Le hook recoit sa charge utile JSON sur l'entree standard.
# Hors hook (appel manuel), rien n'est redirige : on ne bloque pas.
$brut = ''
if ([Console]::IsInputRedirected) {
    $brut = [Console]::In.ReadToEnd()
}

$detail = 'stdin vide'
if ($brut.Trim()) {
    try {
        $o = $brut | ConvertFrom-Json
        $champs = @(
            "event=$($o.hook_event_name)"
            "type=$($o.type)"
            "agent_type=$($o.agent_type)"
            "agent_id=$($o.agent_id)"
            "stop_reason=$($o.stop_reason)"
        ) | Where-Object { $_ -notmatch '=$' }
        $detail = $champs -join ' '
    }
    catch {
        $nettoye = $brut -replace '\s+', ' '
        $detail = 'JSON illisible : ' + $nettoye.Substring(0, [Math]::Min(300, $nettoye.Length))
    }
}

# Rotation : au-dela de 500 000 octets, le journal devient journal-sons.1.log
# (ecrase l'ancien). -ErrorAction Stop : un echec de rotation se voit.
$journalAncien = Join-Path $env:USERPROFILE '.claude\hooks\journal-sons.1.log'
if ((Test-Path -LiteralPath $journal) -and ((Get-Item -LiteralPath $journal).Length -gt 500000)) {
    Move-Item -LiteralPath $journal -Destination $journalAncien -Force -ErrorAction Stop
}
Add-Content -LiteralPath $journal -Encoding utf8 `
    -Value ("[{0}] pid={1} son={2} | {3}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $PID, $Son, $detail)

$chemin = Join-Path $env:WINDIR "Media\$Son"
if (-not (Test-Path -LiteralPath $chemin)) {
    Write-Error "Son introuvable : $chemin"
    exit 1
}

# PlaySync bloque jusqu'a la fin : le processus ne meurt pas avant le son.
# Play() utiliserait un nouveau thread et serait coupe net.
$chrono = [System.Diagnostics.Stopwatch]::StartNew()
(New-Object System.Media.SoundPlayer $chemin).PlaySync()
$chrono.Stop()

# Ligne de fin : absente du journal = processus interrompu pendant la lecture.
Add-Content -LiteralPath $journal -Encoding utf8 `
    -Value ("[{0}] pid={1} fin lecture {2} ({3} ms)" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $PID, $Son, $chrono.ElapsedMilliseconds)
exit 0
