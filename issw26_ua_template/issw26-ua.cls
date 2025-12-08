%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% This file has been newly generated to meet accessivility requirements
%% as LaTeX Template class for extended abstracts for
%% the ISSW 2026 in Whistler, Canada (http://www.issw2018.com)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{issw26-ua}[2025/12/04 PDF/UA-2 compliant two-column ISSW-style class]

% Forward options to base article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Default: two-column article
\PassOptionsToClass{twocolumn}{article}
\LoadClass{article}

% Engine check: we rely on LuaLaTeX for Tagged PDF / PDF/UA
\RequirePackage{iftex}
\ifLuaTeX\else
  \PackageError{issw26-ua}{LuaLaTeX required for PDF/UA}{%
    Please switch your engine to LuaLaTeX.%
  }
\fi

% --------------------------------------------------------------------
% Page size + basic two-column layout (A4, 2.5 cm margins, 0.8 cm column gap)
% --------------------------------------------------------------------
\RequirePackage[
  a4paper,
  left=2.5cm,
  right=2.5cm,
  top=2.5cm,
  bottom=2.5cm
]{geometry}
\setlength\columnsep{0.8cm}   % space between columns (0.8 cm)
\setlength\parindent{12pt}
\setlength\parskip{0pt}


% Subtle micro-typographic improvements
\RequirePackage{microtype}

% Times-like text + math, ISSW/Elsevier-style
\RequirePackage{fontspec}

\setmainfont{Arial} % if available on the system / project
\setsansfont{Arial}
% keep default math (or choose a math font with unicode-math if you really want)


% match elsarticle_issw2018 font metrics
\linespread{1.05} % slightly tight lines

% Hyperlinks + bookmarks (PDF/UA-friendly; metadata handled via DocumentMetadata)
\RequirePackage{hyperref}
\RequirePackage{bookmark}

\RequirePackage[normalem]{ulem} % provides \uline
\RequirePackage{titlesec}

% Bibliography: biblatex + biber, natbib-compatible commands
\RequirePackage[
  backend=biber,
  style=authoryear,
  natbib=true,      % so \citet, \citep work
  maxcitenames=2,
  maxbibnames=99
]{biblatex}

\RequirePackage{etoolbox} %for marcos that make tables taggable
\RequirePackage[table]{xcolor} % enables \rowcolor, colored cells, etc.
\RequirePackage{xparse}          % for \NewDocumentEnvironment
\RequirePackage{caption}
\captionsetup[table]{labelfont=bf, labelsep=colon}
% --------------------------------------------------------------------
% Capture abstract and keywords in boxes (ISSW-style)
% --------------------------------------------------------------------
\newbox\issw@absbox
\newbox\issw@keybox

\renewenvironment{abstract}{%
  \global\setbox\issw@absbox=\vbox\bgroup
    \hsize=\textwidth
    \def\baselinestretch{1}%
    \noindent\normalsize
    \text{ABSTRACT: }\ignorespaces
}{%
  \par\egroup
}


\newenvironment{keyword}{%
  \global\setbox\issw@keybox=\vbox\bgroup
    \hsize=\textwidth
    \normalfont\mdseries\upshape
    \noindent\text{KEYWORDS: }\ignorespaces
}{%
  \par\egroup
}



\makeatletter


% Custom ISSW footnote rule: left-aligned and 80% of column width
% Custom ISSW footnote rule: left-aligned and 80% of column width, no extra vspace

\renewcommand{\footnoterule}{%
  \noindent\rule{0.8\columnwidth}{0.4pt}\par
}
\setlength{\skip\footins}{0pt} % remove space above





% --------------------------------------------------------------------
% elsarticle-style author / address / corresponding author interface
% --------------------------------------------------------------------
\newcommand*\issw@authors{}   % collected author line with superscripts
\newcommand*\issw@affils{}    % collected affiliation lines
\newcommand*\issw@corinfo{}   % corresponding author text

% \author[<affil key>]{<name>}
\renewcommand\author[2][]{%
  % #1 = affiliation key (e.g. 1), optional
  % #2 = author name (can contain \corref{...})
  \ifx\issw@authors\@empty
    \gdef\issw@authors{#2%
      \ifx\relax#1\relax\else\textsuperscript{#1}\fi}%
  \else
    \g@addto@macro\issw@authors{, #2%
      \ifx\relax#1\relax\else\textsuperscript{#1}\fi}%
  \fi
}

% \address[<affil key>]{<affiliation text>}
\newcommand\address[2][]{%
  \ifx\issw@affils\@empty
    \gdef\issw@affils{\textsuperscript{#1}#2}%
  \else
    \g@addto@macro\issw@affils{\\\textsuperscript{#1}#2}%
  \fi
}

% Mark corresponding author in the author line (star)
\newcommand\corref[1]{\textsuperscript{*}\footnotemark}


% Store corresponding author block (to be printed as a footnote)
\newcommand\cortext[2][]{%
  \gdef\issw@corinfo{#2}%
}



% --- Numbering with trailing dot (1. , 1.1. , ...) ---
\renewcommand\thesection{\arabic{section}.}
\renewcommand\thesubsection{\thesection\arabic{subsection}.}
\renewcommand{\ULthickness}{0.08pt} % or 0.08pt if you want very thin

% --- Section: non-bold, Times-like, ISSWish size ---

\titleformat{\section}
  {\normalfont\rmfamily\mdseries\large} % font: Times, non-bold, large
  {\thesection}                         % label e.g. "1."
  {0.5em}                               % space between label and title
  {}                                    % code before title text

% --- Subsection: italic + thin underline, non-bold, Times-like ---
\titleformat{\subsection}
  {\normalfont\rmfamily\mdseries\itshape\normalsize} % italic, non-bold
  {\thesubsection}                                   % label e.g. "1.1."
  {0.5em}
  {\uline}                                          % thin underline under title text

% --- Spacing to roughly match article/ISSW defaults ---
\titlespacing*{\section}
  {0pt}                                   % left indent
  {3.5ex plus 1ex minus .2ex}            % space above
  {2.3ex plus .2ex}                      % space below

\titlespacing*{\subsection}
  {0pt}
  {3.25ex plus 1ex minus .2ex}
  {1.5ex plus .2ex}

% Title + abstract + keywords style similar to elsarticle_issw MaketitleBox

\renewcommand\maketitle{%
  \if@twocolumn
    \twocolumn[%
      \thispagestyle{plain}%
      \vspace*{-1.5\baselineskip}%
      \begin{center}%
        % Title
        {\normalfont\mdseries\upshape
         \def\baselinestretch{1}%
         \large\@title\par}%
        \vskip18pt
        % Authors + affiliations
        {\normalfont\mdseries\upshape
         \normalsize
         \ifx\issw@authors\@empty
           \@author
         \else
           \issw@authors
         \fi
         \par}%
        \ifx\issw@affils\@empty\else
          \vskip6pt
          {\normalfont\mdseries\upshape
           \small \issw@affils\par}%
        \fi
        \vskip24pt
        % Abstract (full width)
        \ifvoid\issw@absbox\else
          {\normalfont\mdseries\upshape
           \noindent\unvbox\issw@absbox\par}%
          \vskip10pt
        \fi
        % Keywords (full width)
        \ifvoid\issw@keybox\else
          {\normalfont\mdseries\upshape
           \noindent\unvbox\issw@keybox\par}%
          \vskip10pt
        \fi
      \end{center}%
    ]%
  \else
    \thispagestyle{plain}%
    \vspace*{-1.5\baselineskip}%
    \begin{center}%
      {\normalfont\mdseries\upshape
       \def\baselinestretch{1}%
       \large\@title\par}%
      \vskip18pt
      {\normalfont\mdseries\upshape
       \normalsize
       \ifx\issw@authors\@empty
         \@author
       \else
         \issw@authors
       \fi
       \par}%
      \ifx\issw@affils\@empty\else
        \vskip6pt
        {\normalfont\mdseries\upshape
         \small \issw@affils\par}%
      \fi
      \vskip24pt
      \ifvoid\issw@absbox\else
        {\normalfont\mdseries\upshape
         \noindent\unvbox\issw@absbox\par}%
        \vskip10pt
      \fi
      \ifvoid\issw@keybox\else
        {\normalfont\mdseries\upshape
         \noindent\unvbox\issw@keybox\par}%
        \vskip10pt
      \fi
    \end{center}%
  \fi
     % Corresponding author block as unnumbered footnote on first page (lower left)
\ifx\issw@corinfo\@empty\else
  \begingroup
    \renewcommand\thefootnote{}%
    \footnotetext{%
      {\footnotesize
        % disable all indentation
        \setlength{\parindent}{0pt}%
        \setlength{\leftskip}{0pt}%
        \setlength{\hangindent}{0pt}%

        % first line, italic
        \noindent\textit{* Corresponding author address:}\\
        \noindent\issw@corinfo
      }%
    }%
  \endgroup
\fi
}

% ============================================================
% Tagged Table (PDF/UA) with caption + label + artifact hlines
% ============================================================
% ============================================================
% Simple taggedtable interface (NO optional argument version)
% ============================================================

% Usage:
% \begin{taggedtable}{h}{tab:example}{A table showing a series of values.}{lcc}
%   \HeaderRow{\textit{Location} & \textit{Value 1 (cm)} & \textit{Value 2 (m)}}
%   \Row{Location a & 9.0 & 7.0}
% \end{taggedtable}

\newenvironment{taggedtable}[4]{%
  % #1 = placement (h, ht, t, b, H, etc.)
  % #2 = \label key
  % #3 = caption text
  % #4 = column format (e.g. lcc)
  \begin{table}[#1]
    \centering
    \caption{#3}%
    \label{#2}%
    \begin{tabular}{#4}%
}{%
    \end{tabular}%
  \end{table}%
}

\newcommand{\HeaderRow}[1]{%
  \hline
  \rowcolor{gray!20}%
  #1\\%
  \hline
}

\newcommand{\Row}[1]{%
  #1\\%
}


% ============================================================
% Accessible equation environment (PDF/UA)
% Usage:
% \begin{AccessibleEquation}{eq:1}{Work W equals the integral from x_0 to x_1 of F dx}
%   W = \int_{x_0}^{x_{1}} F\, dx
% \end{AccessibleEquation}



\makeatother

