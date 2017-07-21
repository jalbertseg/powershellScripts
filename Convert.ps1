param (
    [string]$path = $(throw "Path parameter is required."),    
    [string]$from = "m4a",
    [switch]$delete = $false
 )
Write-Host "Music File converter"

#Set the path to crawl
# Cambiar el directorio a convertir
#$path = '' #put your directory here like C:\XXXXX

Write-Host "Directory: $path"

#The source or input file format
#Tipo de archivo a convertir del directorio seleccionado
#$from = '.ogg' #mp4a, mp4, ogg... Music File type

Write-Host "Filetype: $from"

#Recorre el directorio seleccionado recursivamente seleccionando los ficheros $from

Write-Host "***** Start file conversion *****"
$ffmpeg = "C:\ffmpeg\bin\ffmpeg.exe"
if(Test-Path $ffmpeg){
  if(Test-Path $path){
          Get-ChildItem -Path:$path -Include:"*$from" -Recurse | ForEach-Object -Process: {
          $file = $_.Name.Replace($_.Extension,'.mp3')
          $input = $_.FullName
          $output = $_.DirectoryName
          $output = "$output\$file"
          $arguments = "-i `"$input`" -id3v2_version 3 -c:a libmp3lame -q:a 0 `"$output`" -y -hide_banner"
          Invoke-Expression "$ffmpeg $arguments"
          Write-Host "$file converted to $output"
          if($delete){
            if (Test-Path $input) {
                Write-Host "Deleting.... $input"
                Remove-Item $input
              }
          }
      }
  }
  else
  {
    Write-Host "Dont exist $path"
  }
}
else{
  Write-Host "You MUST install ffmpeg into C:\ffmpeg\"
}

    Write-Host " ***** End file conversion ******"
