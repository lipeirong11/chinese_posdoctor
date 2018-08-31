#!/bin/bash
set -e

#---------------------------------------------------------------------------#
#-                       LaTeX Automated Compiler                          -#
#-                          <By Huangrui Mo>                               -#
#- Copyright (C) Huangrui Mo <huangrui.mo@gmail.com>                       -#
#- This is free software: you can redistribute it and/or modify it         -#
#- under the terms of the GNU General Public License as published by       -#
#- the Free Software Foundation, either version 3 of the License, or       -#
#- (at your option) any later version.                                     -#
#---------------------------------------------------------------------------#

#---------------------------------------------------------------------------#
#->> Preprocessing
#---------------------------------------------------------------------------#
#-
#-> Get source filename
#-
FileName=`echo *.tex`
FileName=${FileName/.tex}
echo $FileName
#-
#-> Get tex compiler
#-
TexCompiler="xelatex"
#-
#-> Get bib compiler
#-
BibCompiler="bibtex"
#-
#-> Set compilation out directory resembling the inclusion hierarchy
#-
#-> Set LaTeX environmental variables to add subdirs into search path
#-
#---------------------------------------------------------------------------#
#->> Compiling
#---------------------------------------------------------------------------#
#-
#-> Build textual content and auxiliary files
#-
$TexCompiler $FileName || exit
#-
#-> Build references and links
#-
#- extract and format bibliography database via auxiliary files
$BibCompiler $FileName
#- insert reference indicators into textual content
#- refine citation references and links
$TexCompiler $FileName || exit
$TexCompiler $FileName || exit

rm -rf ./"$FileName".aux || exit
rm -rf ./"$FileName".bbl || exit
rm -rf ./"$FileName".blg || exit
rm -rf ./"$FileName".lof || exit
rm -rf ./"$FileName".log || exit
rm -rf ./"$FileName".lot || exit
rm -rf ./"$FileName".out || exit
rm -rf ./"$FileName".toc || exit

#---------------------------------------------------------------------------#
#->> Postprocessing
#---------------------------------------------------------------------------#
#-
#-> Set PDF viewer
#-
System_Name=`uname`
if [[ $System_Name == "Linux" ]]; then
PDFviewer="xdg-open"
elif [[ $System_Name == "Darwin" ]]; then
PDFviewer="open"
else
PDFviewer="open"
fi
#-
#-> Open the compiled file
#-
#$PDFviewer ./"$FileName".pdf || exit
echo "---------------------------------------------------------------------------"
echo "$TexCompiler $BibCompiler "$FileName".tex finished..."
echo "---------------------------------------------------------------------------"
