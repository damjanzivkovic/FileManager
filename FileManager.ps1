#Projektleiter: Damjan Zivkovic, 
#Partner: Lejs Malisi
#Datum: 26.3.2022. 
#Ort: Näfels/Siebnen/Rapperswil
#Version: 1.4

clear
$Run = $true;
[int]$Money = 100;
#Als Zusatz haben wir blackjack im programm versteckt.
#Blackjack haben wir in der Freizeit gemacht und haben so mehr Erfahrung zur PowerShell gesammelt, deshalb haben wir es ins Programm getan.
#Aber man kann darauf sowieso nur zugreifen wenn man weiss das es im code ist.
function PlayAgain(){
    write "Do you want to play again?(y/n)"
    $again = Read-Host
    $checking = $true
    while ($checking -eq $true){
        if($again -eq "y"){
            $checking = $false
            $Run = $true
            clear
        }
        elseif($again -eq "n"){
            $Run = $false
        }
        else{
            $checking = $true
        }
    }
}
function BlackJack(){
    clear
    write "Welcome to blackjack!"
    write " "
    #Running
    while($Run -eq $true)
    {
        if($Money -eq 0){
            $Money+=10
            write " "
            write "You got 10 bucks for free, because you had 0."
            write " "
        }
        $betting = $true
        while($betting -eq $true){
            write "You have $Money bucks, Your bet: "
            [int]$bet = read-host 

            $Money
            $bet
            if($bet -le $Money -and $bet -ge 0){
                $betting = $false
            }
            else{
                write-host -f yellow "Invalid bet. Please type in a valid bet"
            }
        }
        $n1 = Get-Random -Minimum 1 -Maximum 10
        $n2 = Get-Random -Minimum 1 -Maximum 11
        $sum = $n1 + $n2

        write "You have: $n1 and $n2"
        write-host -f green "Your sum is: $sum`r`n"

        $hitstand = $true
        while($hitstand -eq $true){
            write "'h' to hit and 's' to stand: `r`n"
            $hitOrstand = Read-Host

            if ($hitOrstand -eq "h"){
                $nNew = Get-Random -Minimum 1 -Maximum 11
                $sum += $nNew
                write "Hit: $nNew"
                write-host -f green "New Sum: $sum"
                write " "
                if($sum -gt 21){
                    $Money-=$bet
                    write-host -f red "Over 21! You're bust!"
                    $hitstand = $false
                    write "You: $sum"
                    write "Dealer: $DealerSum"
                    write " "
                    write-host -f red "You've lost!"
                    write " "
                    PlayAgain
                }
            }
            if ($hitOrstand -eq "s"){
                $hitstand = $false
                #Dealer pulls cards.
                $nDealer1 = Get-Random -Minimum 1 -Maximum 10
                $nDealer2 = Get-Random -Minimum 1 -Maximum 11
                $DealerSum = $nDealer1 + $nDealer2
                write "Dealer: $DealerSum"
                write " "
                while($DealerSum -lt 16){
                    $nDealerNew = Get-Random -Minimum 1 -Maximum 11
                    $DealerSum+=$nDealerNew
                }
                if($DealerSum -gt 21){
                    $DealerSum
                    write-host -f red "The Dealer ist Bust!"
                }
                #Won, Lost, Tied
                if($sum -gt $DealerSum -or $DealerSum -gt 21 -or $sum -gt 21 -and $DealerSum -ne $sum){ #Player Wins
                    if ($sum -eq 21){
                        $Money = $bet + 50
                        write " "
                        write-host -f purple "blackjack!"
                    }
                    else{
                        $Money+=$bet
                    }
                    write "You: $sum"
                    write "Dealer: $DealerSum"
                    write " "
                    write-host -f green "You've won!"
                    write " "
                    PlayAgain
                }
                elseif($sum -lt $DealerSum -or $sum -gt 21 -or $DealerSum -gt 21 -and $DealerSum -ne $sum){
                    $Money-=$bet
                    write "You: $sum"
                    write "Dealer: $DealerSum"
                    write " "
                    write-host -f red "You've lost!"
                    write " "
                    PlayAgain
                }
                elseif($sum -eq $DealerSum -and $DealerSum -lt 22 -and $sum -lt 22){
                    $Money = $Money
                    write "You: $sum"
                    write "Dealer: $DealerSum"
                    write " "
                    write-host -f yellow "Tied!"
                    write " "
                    PlayAgain
                }
            }
        }
    }
    Remove-Variable Money
    Remove-Variable sum
    Remove-Variable DealerSum
    Remove-Variable bet
    Remove-Variable n1
    Remove-Variable n2
    Remove-Variable nNew
    Remove-Variable DealerNew
}
#Hier beginnt das Programm.
#Alle Errors die, das Programm bekommt, sollen nicht angezeigt werden, da diese Errors nichts kaputt machen sondern nur da sind weil das Programm  alles durchgeht.
$ErrorActionPreference = 'SilentlyContinue'
$TEMPexists = $True
$NoTest = $False
#Die Function erstellt Testordner und Files, falls man das Programm testen will
function TestFilesAndFolder(){
    #Es geht zuerst in den C: drive
    cd C:\
    if((Test-Path -Path C:\temp) -eq $False){
        #Falls ein temp file im C: Drive bereits existiert wird das/die file/s anderst genannt
        $TEMPexists = $False
        mkdir temp
        cd temp
        type nul >> some.txt
        type nul >> test.txt
        type nul >> test.pdf
        type nul >> test.png
        type nul >> test.jpg
        type nul >> test1.jpg
        type nul >> test.docx
        type nul >> sv.zip
        cd..
        mkdir temp1
        cd temp1
        type nul >> test.jpg
        type nul >> test1.jpg
        type nul >> test.docx
        type nul >> fortnite.docx
        type nul >> svv.exe
        type nul >> sus.sus
    }
    else{
        #Es wird PowerShellSyncTest und PowerShellSyncTest1, weil mit 99% wahrscheinlichkeit keiner so einen Ordner hat.
        $TEMPexists = $True
        mkdir PowerShellSyncTest
        cd PowerShellSyncTest
        type nul >> some.txt
        type nul >> test.txt
        type nul >> test.pdf
        type nul >> test.png
        type nul >> test.jpg
        type nul >> test1.jpg
        type nul >> test.docx
        type nul >> sv.zip
        cd..
        mkdir PowerShellSyncTest1
        cd PowerShellSyncTest1
        type nul >> test.jpg
        type nul >> test1.jpg
        type nul >> test.docx
        type nul >> fortnite.docx
        type nul >> svv.exe
        type nul >> sus.sus
    }
}

#Wenn man keinen Test machen will geht es normal Weiter ohne vorgegebenen Path
write-host "Wollen Sie Testordner mit Files erstellen? j=ja n=nein"
$test = read-host
if($test -eq "j"){
    TestFilesAndFolder
}
else{
    #Weiter
    $NoTest = $True
}

#Das Programm wird wiederholt während repeat 1 ist
$repeat = 1
while($repeat -eq 1)
{    
    #Der Array, der Alle File-Endungen aufnimmt, die rausgefiltert werden.
    $ExcludeArray = @()
    #Man muss den Array zu einer Liste konvertieren, für den .Add Command.
    [System.Collections.ArrayList]$Exclude = $ExcludeArray
    $Loges = @()
    [System.Collections.ArrayList]$Logs = $Loges
    write-host "Pfad Beispiel: "
    if($TEMPexists -eq $True -and $NoTest -eq $False){
        write-host "Ihr Testpfad ist: "
        write-host " "
        write-host "Pfad1 = C:\PowerShellSyncTest"
        write-host "Pfad2 = C:\PowerShellSyncTest1"
    }
    elseif($TEMPexists -eq $False -and $NoTest -eq $False){
        write-host "Ihr Testpfad ist: "
        write-host " "
        write-host "Pfad1 = C:\temp"
        write-host "Pfad2 = C:\temp1"
    }
    elseif ($NoTest -eq $True){
        write-host "C:\Windows\System32"
    }
    write-host " "
    write-host "Bitte geben Sie den Sourcepath ein, nur Ordner. Am ende des zielordners Ordners KEIN backslash"
    $source = Read-Host
    #Es schaut ob es diesen Path gibt.
    if ((Test-Path -Path $source) -eq $False -and $source -ne "le fishe"){
        write-host -f red "Pfad Nicht vorhanden."
        Start-Sleep -m 4000
        exit
    }
    elseif ($source -eq "le fishe"){
        #Ein kleines "Easter Egg" wenn man le fishe schreibt, öffnet dieses video
        start "https://www.youtube.com/watch?v=3blg4-jRHS0&t=280s"
        Start-Sleep -m 5000
        exit
    }
    else{ 
    }
    write-host "Bitte geben Sie den Destinationpath ein. Am ende des zielordners Ordners KEIN backslash"
    $destination = Read-Host
    if ((Test-Path -Path $destination) -eq $False -and $destination -ne "le fishe"){
        write-host -f red "Pfad Nicht vorhanden."
        Start-Sleep -m 4000
        exit
    }
    elseif ($destination -eq "le fishe"){
        start "https://www.youtube.com/watch?v=3blg4-jRHS0&t=280s"
        Start-Sleep -m 5000
        exit
    }
    else{
    }
    #Die While schleife läuft während man files ausfiltert. Die erste schleife ist, dass wenn man staht j oder n etwas anderes schreibt, das es sich wiederholt.
    while($True){
        write-host "Wollen sie irgendwelche Dateiendungen NICHT rüber kopieren? j=ja, n=nein"
        $choice0 = read-host
        if($choice0 -eq "j"){
            $filtering = 1
            #Diese while Schleife ist zum mehrere Sachen filtern. So dass man mehrere Sachen in die ArrayList tun kann. Wenn man 0 eingibt wird die schleife beendet.
            while ($filtering -eq 1){
                write-host "Welche dateiendung? Geben sie '0' ein wenn sie alle haben."
                $fileendInput = read-host
                $Exclude.Add("*." + $fileendInput)
                if($fileendInput -eq 0){
                    $filtering = 0
                }
            }
            break
        }
        elseif($choice0 -eq "n"){
            break
        }
        else{
            write-host -f red "Ungültige eingabe, nochmal probieren."
        }
    }

    #Man holt sich das letzte Schreib bzw. Bearbeitedatum der Ordner
    $sourceDate = [System.IO.File]::GetLastWriteTime($source)
    $destinationDate = [System.IO.File]::GetLastWriteTime($destination)

    #Die Ordner von Source und Destination path werden jeweils nochmal im ornder erstellt.
    $folderDestination = Split-Path $destination -Leaf
    $folderDestinationForPath = "\" + $folderDestination
    $folderSource = Split-Path $source -Leaf
    $folderSourceForPath = "\" + $folderSource

    #Deshalb muss man hier den namen des Ornders rausfiltern um ihn zu löschen, direkt nach erstellung.
    $DuplicateSourcePathSQ = $source + $folderSourceForPath
    $DuplicateSourcePathDE = $source + $folderDestinationForPath


    #Hier werden alle Files die verschoben werden rausgefiltert um sie ins log file zu tun.
    $sourceFiless = $source + "\*"
    $destinationFiless = $destination + "\*"

    $sourceFilesss = Get-ChildItem $sourceFiless
    $destinationFilesss = Get-ChildItem $destinationFiless

    $sourceFiles = Split-Path $sourceFilesss -Leaf
    $destinationFiles = Split-Path $destinationFilesss -Leaf



    $DuplicateDestinationPathSQ = $destination + $folderDestinationForPath
    $DuplicateDestinationPathSO = $destination + $folderSourceForPath

    $LogCount = 0
    $LogProcess = 1
    #Man schaut, ob die Files im Source Path neuer sind als im Destination Path.
    #Wenn ja, dann werden die Files vom älteren Ornder überschrieben
    if ($sourceDate -gt $destinationDate)
    {
        #Es nimmt die namen der Files und setzt diese die im Destination Path sind und noch nicht im source path in den source path rein. 
        #Ob das File existiert schaut man mit TestPath. Der FullName, nimmt Namen der Files
        Get-ChildItem $destination -Recurse | ForEach {
            $LogCount+=1
            $Mod1 = $($_.FullName).Replace("$destination", "$source")
            if ((Test-Path $Mod1) -eq $False){
                Copy-Item $_.FullName $Mod1 -Exclude $Exclude
                $Logging = "$(get-date -format "dd-mm-yyyy HH:mm:ss"): " + "# " + $destinationFiles + " Copied to " + $source
                if($LogProcess -eq 1){
                    $Logs.Add($Logging)
                    $LogProcess = 0
                }
                $LogProcess = 1
                Get-ChildItem $source -Recurse | ForEach {
                    $ModifiedDestination1 = $($_.FullName).Replace("$source","$destination")
                    Copy-Item $_.FullName $ModifiedDestination1 -Exclude $Exclude
                    $Logging = "$(get-date -format "dd-mm-yyyy HH:mm:ss"): " + "# " + $sourceFiles + " Copied to " + $destination +" "
                    if($LogProcess -eq 1){
                        $Logs.Add($Logging)
                        $LogProcess = 0
                    }
                    
                }
            }
            #Wenn schon jedes File synchronisiert ist, dann tut es nur files vom neueren Ornder in den Älteren und überschreibt somit die älteren.
            else{
                Get-ChildItem $source -Recurse | ForEach {
                    $ModifiedDestination1 = $($_.FullName).Replace("$source","$destination")
                    Copy-Item $_.FullName $ModifiedDestination1 -Exclude $Exclude
                    $Logging = "$(get-date -format "dd-mm-yyyy HH:mm:ss"): " + "# " + $sourceFiles + " Copied to " + $destination
                    if($LogProcess -eq 1){
                        $Logs.Add($Logging)
                        $LogProcess = 0
                    }
                }
            }
            #Wenn man das so macht werden Ornder erstellt, die man danach wieder rauslöschen muss.
            if ((Test-Path -Path $DuplicateDestinationPathSO) -eq $True){
                cd $destination
                rm $folderSource
            }
            if ((Test-Path -Path $DuplicateDestinationPathSQ) -eq $True){
                cd $destination
                rm $folderDestination
            }
            if ((Test-Path -Path $DuplicateSourcePathDE) -eq $True){
                cd $source
                rm $folderDestination
            }
            if ((Test-Path -Path $DuplicateSourcePathSQ) -eq $True){
                cd $source
                rm $folderSource
            }
        }
        
    }
    #Wenn die anderen Files neuer sind macht er es genau anderst rum.
    elseif($destinationDate -gt $sourceDate){
        Get-ChildItem $source -Recurse | ForEach {
            $LogCount += 1
            $Mod0 = $($_.FullName).Replace("$source","$destination")
            if ((Test-Path $Mod0) -eq $False){
                Copy-Item $_.FullName $Mod0 -Exclude $Exclude
                $Logging = "$(get-date -format "dd-mm-yyyy HH:mm:ss"): " + "# " + $sourceFiles + " Copied to " + $destination
                if($LogProcess -eq 1){
                    $Logs.Add($Logging)
                    $LogProcess = 0
                }
                $LogProcess = 1
                Get-ChildItem $destination -Recurse | ForEach {
                    $ModifiedDestination2 = $($_.FullName).Replace("$destination", "$source")
                    Copy-Item $_.FullName $ModifiedDestination2 -Exclude $Exclude
                    $Logging = "$(get-date -format "dd-mm-yyyy HH:mm:ss"): " + "# " + $destinationFiles + " Copied to " + $source
                    if($LogProcess -eq 1){
                        $Logs.Add($Logging)
                        $LogProcess = 0
                    }
                }
            }
            else{
                Copy-Item $destination -Destination $source
                Get-ChildItem $destination -Recurse | ForEach {
                    $ModifiedDestination2 = $($_.FullName).Replace("$destination", "$source")
                    Copy-Item $_.FullName $ModifiedDestination2 -Exclude $Exclude
                    $Logging = "$(get-date -format "dd-mm-yyyy HH:mm:ss"): " + "# " + $destinationFiles + " Copied to " + $source
                    if($LogProcess -eq 1){
                        $Logs.Add($Logging)
                        $LogProcess = 0
                    }
                    
                }
            }
            if ((Test-Path -Path $DuplicateSourcePathDE) -eq $True){
                cd $source
                rm $folderDestination
            }
            if ((Test-Path -Path $DuplicateSourcePathSQ) -eq $True){
                cd $source
                rm $folderSource
            }
            if ((Test-Path -Path $DuplicateDestinationPathSO) -eq $True){
                cd $destination
                rm $folderSource
            }
            if ((Test-Path -Path $DuplicateDestinationPathSQ) -eq $True){
                cd $destination
                rm $folderDestination
            }
        }

    }

    write-host " "
    write-host " "
    write-host -f green "Erfolgreich Synchronisiert!"

    echo $Logs >> "$source\logs.log"

    #Alle Variablen die wichtig sind zurücksetzen
    if($tempvar -eq 1){
        Remove-Variable fileendInput
    } 
    Remove-Variable Exclude

    write-host "Wollen Sie noch einmal synchronisieren? j=ja, n=nein, else=nein"
    #Diese Auswahl ist nur, damit man einen Weg hat auf Blackjack zuzugreifen, aber da man ja oder nein schreiben sollte wird man nicht wissen das da noch was dahinter steckt.
    $choice = read-host
    if($choice -eq "j"){
        $repeat = 1
    }
    elseif ($choice -eq "n"){
        $repeat = 0
    }
    elseif($choice -eq "blackjack"){
        BlackJack
    }
    else{
        write-host " "
        write-host -f red "Exiting..."
        exit
    }
}

$name = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$name = Split-Path $name -Leaf
$userPath = "C:\Users\$name"
cd $userPath