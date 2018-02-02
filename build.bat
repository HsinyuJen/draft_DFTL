call "D:\Program Files\latex\tools_2014.bat" 
rem call "E:\Program Files\latex\tools_2014.bat" 
call "C:\latex\tools_2017.bat"

set path=%path%;E:\projects\latex\journal\rsd_draft;
pdflatex draft.tex 
bibtex draft.aux 
pdflatex draft.tex 
pdflatex draft.tex
run.bat
