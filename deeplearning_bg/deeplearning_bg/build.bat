rem call "D:\Tools\tools_2014.bat"
call "D:\tools.bat"
rem set path=%path%;E:\projects\latex\journal\BGModel_superpixel_draft;
pdflatex typeinst.tex 
bibtex typeinst.aux 
pdflatex typeinst.tex 
pdflatex typeinst.tex
run.bat
