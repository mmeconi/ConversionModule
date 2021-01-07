<#
    .SYNOPSIS
        This module contains functions related to converting decimal, hexadecimal, and binary numbers
        into eachother, as well as outputting the conversions to a CSV file and HTML file.
    .DESCRIPTION
        Each function in this module begins by testing if the conversion.csv file exists; if it does, it continues
        with that particular function's primary responsibilities, otherwise it creates the file then carries on.
        Utilizing string methods, among others, the functions convert the input into the required numerical
        system, then outputs the conversions to the CSV file. You can view the CSV file, or view the data in
        your web browser as there is a function to convert to HTML.
    .NOTES
        AuthorsNames: Negin Habibi, Raphner Magcalas, Marc Meconi
        DateLastModified: December 11, 2020
 #>

New-Alias -name gb -value Get-BinaryNumber
New-Alias -name gh -value Get-HexadecimalNumber
New-Alias -name gd -value Get-Decimal

#////////////////////// GET-MENUHELPER \\\\\\\\\\\\\\\\\\\
function get-menuhelper {

# Displays Menu
Do{
Clear-host
write-host "=========================================================" -ForegroundColor magenta -BackgroundColor black
write-host "================== PLEASE SELECT BELOW ==================" -ForegroundColor magenta -BackgroundColor black
write-host "=========================================================" -ForegroundColor magenta -BackgroundColor black
write-host "=                                                       =" -ForegroundColor magenta -BackgroundColor black
write-host "=            [1]  Enter Decimal Number                  =" -ForegroundColor magenta -BackgroundColor black
write-host "=            [2]  Enter Hexadecimal Number              =" -ForegroundColor magenta -BackgroundColor black
write-host "=            [3]  Enter Binary Number                   =" -ForegroundColor magenta -BackgroundColor black
write-host "=            [4]  Display CSV File                      =" -ForegroundColor magenta -BackgroundColor black
write-host "=            [5]  Show CSV File in Browser              =" -ForegroundColor magenta -BackgroundColor black
write-host "=            [6]  Exit                                  =" -ForegroundColor magenta -BackgroundColor black
write-host "=                                                       =" -ForegroundColor magenta -BackgroundColor black
write-host "=========================================================" -ForegroundColor magenta -BackgroundColor black
write-host "================== GROUP F - WIN213 =====================" -ForegroundColor magenta -BackgroundColor black
write-host "======= Negin Habibi, Raphner Magcalas, Marc Meconi======" -ForegroundColor magenta -BackgroundColor black
write-host "=========================================================" -ForegroundColor magenta -BackgroundColor black

# User input, which is inserted into a switch for branching
$response = read-host "Make a valid selection"

    switch($response){
        (1) {Get-Decimal; pause}
        (2) {Get-HexadecimalNumber; pause}
        (3) {Get-BinaryNumber; pause}
        (4) {Show-Conversions; pause}
        (5) {Show-HTMLConversions; pause}
        (6) {break}
        default {"Invalid Choice"}
        }

}until($response -eq 6)

} #end of get-menuhelper

#////////////////////// SHOW-MENU \\\\\\\\\\\\\\\\\\\\\

function Show-Menu {
    Get-MenuHelper
    } #end of Show-Menu


#////////////////////// GET-DECIMAL \\\\\\\\\\\\\\\\\\\\

function Get-Decimal {

$TestFilePath = Test-path -path "$home\documents\conversion.csv"
$filepath = "$home\documents\conversion.csv"
[string]$date = get-date -format "MM/dd/yyyy"

# Test if file conversion.csv exists; if not, create it
if ($TestFilePath -eq $True){
    Out-null
}else{
    write-host "conversion.csv does not exist; creating file"
    pause
    new-item -path "$home\documents\" -name "conversion.csv" -ItemType file | Out-Null
    }


do {
#******************************************************************
#                         RAPHNER CODE BEGINS
#******************************************************************

    #prompting the decimal value from the user
    [int]$decimal = Read-Host "Enter a decimal number[1-255]"
    #checking whether the input is decimal or not
    if($decimal -gt 0 -and $decimal -lt 256) #-and $decimal -ne 0)
    {
        #convert decimal to binary
        $binary = [convert]::ToString($decimal,2)

        #conver decimal to hexadecimal
        $hexadecimal = [convert]::ToString($decimal,16)  
        
    }
    else
    {
        #this warning message will prompt if they did not enter a decimal number
        Write-Warning "Please enter a valid Decimal number"

#******************************************************************
#                         RAPHNER CODE ENDS
#******************************************************************    
        
        pause
    }
    }until($decimal -gt 0 -and $decimal -lt 256)


[int]$number = import-csv $filepath | Measure-Object | Select-Object -expandproperty count

# Output conversions to CSV file
[pscustomobject] @{
Number = ($number + 1)
Date = "$Date"
Binary = "$binary"
Decimal = "$decimal"
Hexadecimal = "$hexadecimal"
} | Export-CSV -NoTypeInformation -Append "$filepath"

#Conversions are displayed in the console
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"{0,-20}{1,-20}{2,-20}" -f "Binary","Decimal","Hexadecimal"
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"{0,-20}{1,-20}{2,-20}" -f "$binary","$decimal","$hexadecimal"


} #End of Get-Decimal


#////////////////////// GET-HEXADECIMALNUMBER \\\\\\\\\\\\\\\\\\\

function Get-HexadecimalNumber {

$TestFilePath = Test-path -path "$home\documents\conversion.csv"
$filepath = "$home\documents\conversion.csv"
[string]$date = get-date -format "MM/dd/yyyy"

# Test if file conversion.csv exists; if not, create it
if ($TestFilePath -eq $True){
    Out-null
}else{
    write-host "conversion.csv does not exist; creating file"
    pause
    new-item -path "$home\documents\" -name "conversion.csv" -ItemType file | Out-Null
    }

do{
#******************************************************************
#                         RAPHNER CODE BEGINS
#******************************************************************


    
    $hexadecimal = Read-Host "Enter a hexadecimal number [0x3F]"
    if($hexadecimal -like "0x*")
    #this will remove ox

    {
        #this will convert it to hexadecimal and binary
        
        $Binary = [convert]::ToString($Hexadecimal, 2)
        #converting into binary

        $Decimal = [convert]::ToString($Hexadecimal, 10)
        #converting into decimal
        
    }
    else
    {
        Write-Warning "Please enter a valid Hexadecimal number [0xfff]"
#******************************************************************
#                         RAPHNER CODE ENDS
#******************************************************************
        pause
       
    }
    } until ($hexadecimal -like "0x*")

[int]$number = import-csv $filepath | Measure-Object | Select-Object -expandproperty count

# Output conversions to CSV file
[pscustomobject] @{
Number = ($number + 1)
Date = "$Date"
Binary = "$binary"
Decimal = "$decimal"
Hexadecimal = "$hexadecimal"
} | Export-CSV -NoTypeInformation -Append "$filepath"

#Conversions are displayed in the console
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"{0,-20}{1,-20}{2,-20}" -f "Binary","Decimal","Hexadecimal"
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"{0,-20}{1,-20}{2,-20}" -f "$binary","$decimal","$hexadecimal"


} #End of Get-HexadecimalNumber


#////////////////////// GET-BINARYNUMBER \\\\\\\\\\\\\\\\\\\\


function Get-BinaryNumber {

#Variable declarations
$pattern = '^[01]{1,8}$'
$filepath = "$home\documents\conversion.csv"
$DecimalConv = 0
$RemainderArray=@()
[string]$Hexconv1 = "0"
[string]$Hexconv2 = "0"
[string]$date = get-date -format "MM/dd/yyyy"


#Test if the file "conversion.csv" exists; if it doesn't, create it.
$TestFilePath = Test-path -path "$home\documents\conversion.csv"

if ($TestFilePath -eq $True){
    Out-null
}else{
    write-host "conversion.csv does not exist; creating file"
    pause
    new-item -path "$home\documents\" -name "conversion.csv" -ItemType file | Out-Null
    }

#Prompt user for input of binary number. Matches input to $pattern. Continues until valid input received.
do{
[string]$binarynum = Read-Host "Enter valid binary number"

If ($binarynum -match $pattern){
    out-null
}else{
    Write-Host "Invalid input" -foregroundcolor red -backgroundcolor black
    }
}until($binarynum -match $pattern)


<#This section converts the input to a character array, and reverses it. Reversing makes processing the values
much easier since we don't always know the value of the MSB (most significant bit), but we always know the value 
of the LSB. The values are inserted into a "for" loop, which uses a switch to ascertain the decimal value of each
bit. These values are added to the variable $Decimalconv, which is a sum of all binary bits.
#>
$BinaryArray = $binarynum.tochararray()
[array]::Reverse($BinaryArray)

for($i=0; $i -lt $Binaryarray.count; $i++){
    if ($BinaryArray[$i] -eq "1"){
    switch($i){
    (0){$DecimalConv += 1}
    (1){$DecimalConv += 2}
    (2){$DecimalConv += 4}
    (3){$DecimalConv += 8}
    (4){$DecimalConv += 16}
    (5){$DecimalConv += 32}
    (6){$DecimalConv += 64}
    (7){$DecimalConv += 128}
    }
    }
    }


<#This section is in regards to the hexadecimal conversion. I decided that the easiest way to do this would be
to ensure we always have 8 bits, regardless of how many bits were originally inputted, then split the bits into 2 seperate
hextets, and evaluate each of those with a switch. Then, each hextet would be concatenated together.

To achieve this, we reverse our input again (i.e. returning
it to its initial state); then, I've created an "If" block containing a "Do Until" loop that will determine how many bits
are required to have 8 bits in total. It then adds these remaining bits to an array.
#>
[array]::Reverse($BinaryArray)
                                        
If ($BinaryArray.count -lt 8){
    $remainder = 8 - $BinaryArray.count
    Do{
    $RemainderArray += "0"}
    until($remainderarray.count -eq $remainder)
    }

<# The arrays containing our original input and the remaining bits (described directly above) are turned into strings
and concatenated into a single string of 8 binary bits. I then used the "SubString" method to break the string into
two hextets.
#>

[string]$hex1string = -join $remainderarray
[string]$hex2string = -join $binaryarray
[string]$z = $hex1string + $hex2string
$hex1 = $z.Substring(0,4)
$hex2 = $z.Substring(4,4)

# The two hextets above are now inserted into switches to evaluate their hexadecimal value

switch($hex1){
    ("0000"){$Hexconv1 = "0"}
    ("0001"){$Hexconv1 = "1"}
    ("0010"){$Hexconv1 = "2"}
    ("0011"){$Hexconv1 = "3"}
    ("0100"){$Hexconv1 = "4"}
    ("0101"){$Hexconv1 = "5"}
    ("0110"){$Hexconv1 = "6"}
    ("0111"){$Hexconv1 = "7"}
    ("1000"){$Hexconv1 = "8"}
    ("1001"){$Hexconv1 = "9"}
    ("1010"){$Hexconv1 = "A"}
    ("1011"){$Hexconv1 = "B"}
    ("1100"){$Hexconv1 = "C"}
    ("1101"){$Hexconv1 = "D"}
    ("1110"){$Hexconv1 = "E"}
    ("1111"){$Hexconv1 = "F"}
    Default {$null}
    }

switch($hex2){
    ("0000"){$Hexconv2 = "0"}
    ("0001"){$Hexconv2 = "1"}
    ("0010"){$Hexconv2 = "2"}
    ("0011"){$Hexconv2 = "3"}
    ("0100"){$Hexconv2 = "4"}
    ("0101"){$Hexconv2 = "5"}
    ("0110"){$Hexconv2 = "6"}
    ("0111"){$Hexconv2 = "7"}
    ("1000"){$Hexconv2 = "8"}
    ("1001"){$Hexconv2 = "9"}
    ("1010"){$Hexconv2 = "A"}
    ("1011"){$Hexconv2 = "B"}
    ("1100"){$Hexconv2 = "C"}
    ("1101"){$Hexconv2 = "D"}
    ("1110"){$Hexconv2 = "E"}
    ("1111"){$Hexconv2 = "F"}
    Default {$null}
    }

#The hexadecimal values of each hextet are concatenated into a single hexadecimal value
[string]$hexconvFinal = $hexconv1 + $hexconv2

#Conversions are appended to the conversion.csv file

[int]$number = import-csv $filepath | Measure-Object | Select-Object -expandproperty count

[pscustomobject] @{
Number = ($number + 1)
Date = "$Date"
Binary = "$z"
Decimal = "$decimalconv"
Hexadecimal = "$hexconvfinal"
} | Export-CSV -NoTypeInformation -Append "$filepath"

#Conversions are displayed in the console
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"{0,-20}{1,-20}{2,-20}" -f "Binary","Decimal","Hexadecimal"
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"{0,-20}{1,-20}{2,-20}" -f "$z","$decimalconv","$hexconvfinal"


} #end of Get-BinaryNumber

#////////////////////// SHOW-CONVERSIONS \\\\\\\\\\\\\\\\\\\\

function Show-Conversions {

#Path to conversion.csv file
$filepath = "$home\documents\conversion.csv"

#Test if the file "conversion.csv" exists; if it doesn't, create it.
$TestFilePath = Test-path -path $Filepath

if ($TestFilePath -eq $True){
    Out-null
}else{
    write-host "conversion.csv does not exist; creating file"
    pause
    new-item -path "$home\documents\" -name "conversion.csv" -ItemType file | Out-Null
    }

#Import and Display CSV File
$csv = Import-Csv $filepath | Format-Table
$csv
} #end of Show-Conversions

#////////////////////// SHOW-HTMLCONVERSIONS \\\\\\\\\\\\\\\\\\\\

function Show-HTMLConversions {

# Test if file conversion.csv exists; if not, create it
$TestFilePath = Test-path -path "$home\documents\conversion.csv"
if ($TestFilePath -eq $True){
    Out-null
}else{
    write-host "conversion.csv does not exist; creating file"
    pause
    new-item -path "$home\documents\" -name "conversion.csv" -ItemType file | Out-Null
    }

#create variables
$filepath = "$home\documents\Conversion.csv"
$Dirpath = "$home\documents"
$FileName = "conversion.html"
$Date = (Get-Date).ToShortDateString()

   $numbers = $Filepath | Import-CSV
#Create style sheet for web page
 $header = @"
  <style>
 TABLE {border-width: 2px;border-sytle: solid;border-color: black;border-collapse: collapse;}
 TH {border-width: 2px; padding: 5px;border-style: solid; border-color: black;background-color:#bde9ba;}
 TD {border-width: 2px;padding: 5px;border-style: solid; border-color: black;}
 </style>
"@
#create HTML file and open
$numbers|ConvertTo-HTML -head $header -Title "Conversion Data" -body (Get-Date) > "$Dirpath\$FileName"
Start-Process  chrome "$DirPath\$FileName" -wait


} #end of Show-HTMLConversions


Export-ModuleMember -function * -Alias *