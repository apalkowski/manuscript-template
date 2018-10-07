% Configuration file for producing cover letters in LaTeX.

\newcommand*{\mycv@date}{2018/10/04}
\newcommand*{\mycv@version}{1.0}
\newcommand*{\mycv@name}{mycoverletter}
\newcommand*{\mycv@description}{Journal cover letter class}
\newcommand*{\mycv@parentclass}{letter}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\mycv@name}[\mycv@date\space v\mycv@version\space \mycv@description]

%%% ETOOLBOX

\RequirePackage{etoolbox}

%%% CLASS OPTIONS

\DeclareOption{letterpaper}{\OptionNotUsed}
\DeclareOption{a4paper}{\OptionNotUsed}
\DeclareOption{a5paper}{\OptionNotUsed}
\DeclareOption{b5paper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{fleqn}{\OptionNotUsed}
\DeclareOption{leqno}{\OptionNotUsed}
\DeclareOption{titlepage}{\OptionNotUsed}
\DeclareOption{notitlepage}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{landscape}{\OptionNotUsed}
\DeclareOption{openright}{\OptionNotUsed}
\DeclareOption{openany}{\OptionNotUsed}
\DeclareOption{draft}{\OptionNotUsed}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{\mycv@parentclass}%
}

\ProcessOptions\relax

\LoadClass[12pt]{\mycv@parentclass}

%%% PACKAGES

% Page layout
\RequirePackage{geometry}
\geometry{paper=letterpaper}
\geometry{margin=2.5cm}

\pagestyle{empty}

% Document encoding
\RequirePackage[T1]{fontenc}

\RequirePackage[utf8]{inputenc}

% Mathematics
\RequirePackage{mathtools}

\newcommand*{\imgunit}{\ensuremath{\mathrm{i}}}

% Language
\RequirePackage[british]{babel}

% Fonts
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}

\RequirePackage[varl]{inconsolata}

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
\DeclareSIUnit[number-unit-product={},list-units=repeat,range-units=repeat]\percent{\%}

% Colors
\RequirePackage[fixpdftex,hyperref]{xcolor}

% Typography
\RequirePackage[nodisplayskipstretch]{setspace}
\singlespacing
\AtBeginDocument{%
  \deflength{\belowdisplayshortskip}{\belowdisplayskip}%
}

\RequirePackage{enumitem}
\setlist{noitemsep}

\RequirePackage{csquotes}

\RequirePackage{hyphenat}

\RequirePackage{microtype}
\microtypesetup{babel=true}

% Links
\RequirePackage{hyperref}
\hypersetup{unicode=true}
\hypersetup{hidelinks}

%%% CUSTOM COMMANDS

\newcommand{\mycv@sig}{Name}
\newcommand{\sig}[1]{%
  \renewcommand{\mycv@sig}{#1}%
}

\newcommand{\mycv@contactinfo}{Address}
\newcommand{\contactinfo}[1]{%
  \renewcommand{\mycv@contactinfo}{#1}%
}

\newcommand{\papertitle}{\enquote{Paper Title}}
\newcommand{\paper}[1]{%
  \renewcommand{\papertitle}{\enquote{#1}}%
}

\newcommand{\journaltitle}{Journal Name}
\newcommand{\journal}[1]{%
  \renewcommand{\journaltitle}{#1}%
}

\AtBeginDocument{%
  \begin{tabular}{@{}l}
    Editorial Board, \\
    \journaltitle    \\
  \end{tabular}

  \bigskip
  Dear Editor,
  \bigskip
}

\AtEndDocument{%
  \bigskip
  Yours sincerely,

  \vspace{1.5cm}
  \mycv@sig

  \smallskip\footnotesize
  \begin{tabular}{@{}l}
    \mycv@contactinfo
  \end{tabular}
}
