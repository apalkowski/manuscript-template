% Configuration file for producing LaTeX graphics.

\newcommand*{\mypic@date}{2018/10/04}
\newcommand*{\mypic@version}{1.0}
\newcommand*{\mypic@name}{mytexpicture}
\newcommand*{\mypic@description}{Journal picture class}
\newcommand*{\mypic@parentclass}{standalone}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\mypic@name}[\mypic@date\space v\mypic@version\space \mypic@description]

%%% ETOOLBOX

\RequirePackage{etoolbox}

%%% CLASS OPTIONS

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{\mypic@parentclass}%
}

\ProcessOptions\relax

\LoadClass[12pt]{\mypic@parentclass}

%%% PACKAGES

% Document encoding
\RequirePackage[T1]{fontenc}

\RequirePackage[utf8]{inputenc}

% Mathematics
\RequirePackage{mathtools}

\newcommand*{\imgunit}{\ensuremath{\mathrm{i}}}

% Language
\RequirePackage[british]{babel}

% Fonts
\RequirePackage[scaled=1.111111]{newtxtext}%
\RequirePackage{newtxmath}%

\RequirePackage[varl]{inconsolata}

\newlength{\mainfontsize}
\deflength{\mainfontsize}{8pt}

\newlength{\labelfontsize}
\deflength{\labelfontsize}{9pt}

\newcommand*{\mainfont}{\scriptsize}
% \newcommand*{\labelfont}{\footnotesize}

% \newcommand*{\mainfont}{%
%   \fontsize{\mainfontsize}{1.2\mainfontsize}\selectfont%
% }
\newcommand*{\labelfont}{%
  \fontsize{\labelfontsize}{1.2\labelfontsize}\selectfont%
}

\renewcommand{\familydefault}{\sfdefault}

% Units
\RequirePackage[binary-units]{siunitx}
\sisetup{%
  per-mode=symbol,
  group-separator={,},
  group-digits=integer,
  group-minimum-digits=4,
  list-final-separator={, and },
  range-phrase={--},
  list-units=single,
  range-units=single,
  detect-all,
}
\ExplSyntaxOn%
\cs_new_eq:NN \siunitx_table_collect_begin:Nn \__siunitx_table_collect_begin:Nn%
\ExplSyntaxOff%
\DeclareSIUnit[number-unit-product={},list-units=repeat,range-units=repeat]\percent{\%}

% Tables and colors
\RequirePackage{array}

\RequirePackage[table,fixpdftex]{xcolor}

\RequirePackage{longtable}

\RequirePackage[referable]{threeparttablex}
\renewcommand{\TPTLnotesnamefontcommand}{}

\RequirePackage{tabu}
\tabulinesep=1ex

\RequirePackage{booktabs}

% Graphics
\newlength{\maxfullpagewidth}
\deflength{\maxfullpagewidth}{150mm}
\newlength{\maxhalfpagewidth}
\deflength{\maxhalfpagewidth}{70mm}

\RequirePackage{graphicx}
\DeclareGraphicsExtensions{.pdf,.png,.jpg}

\RequirePackage{tikz}
\usetikzlibrary{babel}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{positioning}
\usetikzlibrary{calc}
\usetikzlibrary{fit}
\tikzset{%
  every picture/.style={auto,font=\mainfont,outer sep=auto,thick},
  arrow/.style={->,>=Latex,draw},
  txt/.style={inner sep=0.1mm,align=center},
  img/.style={inner sep=0mm,outer sep=0mm},
  axis_label/.style={txt,color=black,anchor=south west,font=\labelfont\bfseries},
  axis_element/.style={color=black!85},
  axis_line/.style={axis_element,line width=0.8pt},
  plot_line/.style={line width=1.5pt,rounded corners=1pt,line cap=rect,color=C0},
}

\newlength{\ticklength}
\deflength{\ticklength}{3.5pt}
\newlength{\ticklabelshift}
\deflength{\ticklabelshift}{\ticklength+3.5pt}
\newlength{\axislabelshift}
\deflength{\axislabelshift}{6pt}

% Typography
\RequirePackage{enumitem}
\setlist{noitemsep}

\RequirePackage{csquotes}

\RequirePackage{hyphenat}

\RequirePackage{microtype}
\microtypesetup{babel=true}

% Sans-serif mathematics
\RequirePackage{sfmath}

% Colors from Matplotlib color cycle
\definecolor{C0}{HTML}{006BA4}
\definecolor{C1}{HTML}{FF800E}
\definecolor{C2}{HTML}{ABABAB}
\definecolor{C3}{HTML}{595959}
\definecolor{C4}{HTML}{5F9ED1}
\definecolor{C5}{HTML}{C85200}
\definecolor{C6}{HTML}{898989}
\definecolor{C7}{HTML}{A2C8EC}
\definecolor{C8}{HTML}{FFBC79}
\definecolor{C9}{HTML}{CFCFCF}
