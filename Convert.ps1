
Write-Host "Music File converter"

#Set the path to crawl
# Cambiar el directorio a convertir
$path = 'F:\MusicaMiri'

Write-Host "Directory: $path" 

#The source or input file format
#Tipo de archivo a convertir del directorio seleccionado
$from = '.ogg'

Write-Host "Filetype: $from"

#Recorre el directorio seleccionado recursivamente seleccionando los ficheros $from

Write-Host "***** Start file conversion *****"

Get-ChildItem -Path:$path -Include:"*$from" -Recurse | ForEach-Object -Process: {
        $file = $_.Name.Replace($_.Extension,'.mp3')
        $input = $_.FullName
        $output = $_.DirectoryName
        $output = "$output\$file"
        $arguments = "-i `"$input`" -id3v2_version 3 -c:a libmp3lame -q:a 0 `"$output`" -y"
        $ffmpeg = ".'C:\ffmpeg\bin\ffmpeg.exe'"
        Invoke-Expression "$ffmpeg $arguments"
        Write-Host "$file converted to $output"        
    }
    Write-Host " ***** End file conversion ******"