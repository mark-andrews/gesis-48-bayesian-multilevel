\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{slides}
[2015/3/26, Mark Andrews's Beamer slides class.]

\LoadClass[10pt,xcolor=dvipsnames,serif,professionalfont]{beamer}

\RequirePackage{pifont,manfnt}
\RequirePackage{booktabs}
\RequirePackage[T1]{fontenc}
\RequirePackage{mathpazo}
\RequirePackage{eulervm}
\RequirePackage{tikz}
\linespread{1.05}
\RequirePackage{xspace}
\RequirePackage{apacite}
\RequirePackage{rotating}
\RequirePackage{multirow}
\input{andrews_commands}

\newcommand\iidsim{\mathrel{\overset{\makebox[0pt]{\mbox{\normalfont\tiny iid}}}{\sim}}}
\newcommand\defeq{\mathrel{\overset{\makebox[0pt]{\mbox{\normalfont\tiny def}}}{=}}}
\newcommand{\hpd}{\textsc{hpd}\xspace}

\setbeamerfont{title}{family=\it}
\setbeamerfont{frametitle}{family=\it}

\RequirePackage{tikz}
\usetikzlibrary{trees}

\RequirePackage{amssymb,latexsym,amsmath,amsfonts,amscd}

\usecolortheme[named=Gray]{structure} 
\setbeamercolor{titlelike}{fg=black!60!red}
\definecolor{Mygrey}{gray}{0.75}


\graphicspath{{../images/}}

\DeclareSymbolFont{legacymaths}{OT1}{cmr}{m}{n}
\DeclareMathAccent{\dot}     {\mathalpha}{legacymaths}{95}
\DeclareMathAccent{\bar}     {\mathalpha}{legacymaths}{22}
\DeclareMathAccent{\tilde}     {\mathalpha}{legacymaths}{126}
