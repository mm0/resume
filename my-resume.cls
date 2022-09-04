%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my-resume.cls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLASS OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my-resume}[07-01-2022 my-resume v0.1.]

% option to have a single sided document, i.e. the highlight bar is always left
% or have a two sided document where the highlight bar is alternating, i.e. always on the same edge of the paper
\RequirePackage{ifthen}
\newboolean{@singleordouble}
\setboolean{@singleordouble}{true}
\DeclareOption{singlesided}{\setboolean{@singleordouble}{true}}
\DeclareOption{doublesided}{\setboolean{@singleordouble}{false}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions*

\ifthenelse{\boolean{@singleordouble}}
    {\PassOptionsToClass{oneside}{scrartcl}}
    {\PassOptionsToClass{twoside}{scrartcl}}

\LoadClass{scrartcl}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REQUIRED PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{fontawesome}
\RequirePackage{academicons}
\RequirePackage{pifont}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILTER IRRELEVANT WARNINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{silence}

% The page header is deliberately disabled in my-resume, so the warning by scrlayer-scrpage is invalid. 
\WarningFilter{scrlayer-scrpage}{Very small head height detected!}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE GEOMETRY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength\highlightwidth
\newlength\headerheight
\newlength\marginleft
\newlength\marginright
\newlength\margintop
\newlength\marginbottom

% default sizes, margins, ...
\setlength\highlightwidth{3.0cm}
\setlength\headerheight{3.6cm}
\setlength\marginleft{0.6cm}
\setlength\marginright{\marginleft}
\setlength\margintop{0.6cm}
\setlength\marginbottom{0.6cm}

\RequirePackage[bindingoffset=0cm,nomarginpar,noheadfoot]{geometry}
\geometry{left=\marginleft,right=\marginright,top=\margintop,bottom=\marginbottom}

% \setlength{\voffset}{\dimexpr -1in+\margintop}
% \setlength{\topmargin}{0cm}

% minipage has an annoying af indent that must be removed
\setlength{\parindent}{0pt}
\setlength{\lineskip}{0pt}
\setlength{\parskip}{0pt}
\setlength{\baselineskip}{0pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xcolor}

% Gray-scale colors
\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{darkgray}{HTML}{333333}
\definecolor{mediumgray}{HTML}{444444}
\definecolor{gray}{HTML}{5D5D5D}
% Basic colors
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}
% Text colors
\definecolor{darktext}{HTML}{414141}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
% Awesome colors
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORED BARS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xpatch}
\RequirePackage{scrlayer-scrpage}

% declare new page style using layers
\DeclareNewPageStyleByLayers{headerhighlightmain}{%
  highlightbar.even,%
  highlightbar.odd,%
  header.bg
}
\DeclareNewPageStyleByLayers{highlightmain}{%
  highlightbar.even,%
  highlightbar.odd
}
\DeclareNewPageStyleByLayers{headermain}{%
  header.bg
}

% define the layer for the highlight bar on odd pages
\DeclareNewLayer[
  background,
  oddpage,
  innermargin,
  align=l,
  width=\highlightwidth,
  contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
]{highlightbar.odd}

% clone highlight bar form odd pages to even pages
% on same side for digital format
\newcommand*\highlightbarsingle{%
  \DeclareNewLayer[
    background,
    evenpage,
    outermargin,
    align=l,
    width=\highlightwidth,
    contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
  ]{highlightbar.even}
}

% clone highlight bar from odd pages to even pages
% on opposite sides for prints
\newcommand*\highlightbardouble{%
\DeclareNewLayer[
    clone=highlightbar.odd,
    evenpage,
    align=r,
    hoffset=\paperwidth
  ]{highlightbar.even}
 }

% use the correct version of the highlight bar on even pages
% single for single, double for double
\ifthenelse{
    \boolean{@singleordouble}
}{%
    \DeclareNewLayer[
      background,
      evenpage,
      outermargin,
      width=\highlightwidth,
      contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
    ]{highlightbar.even}
}{%
    \DeclareNewLayer[
        clone=highlightbar.odd,
        evenpage,
        align=r,
        hoffset=\paperwidth
      ]{highlightbar.even}
}

% define the layer for the header 
\DeclareNewLayer[
  background,
  topmargin,
  addheight=\headerheight,
  width=\highlightwidth,
  contents={\color{headerbarcolor}\rule{\highlightwidth}{\layerheight}}
]{header.bg}

% % add the layers to page style plain
% \ForEachLayerOfPageStyle*{headerhighlightmain}{%
%   \AddLayersToPageStyle{plain.scrheadings}{#1}%
% }

% remove anything that might be there (page number) from header and footer
\lehead[]{}
\cehead[]{}
\rehead[]{}
\lohead[]{}
\cohead[]{}
\rohead[]{}
\lefoot[]{}
\cefoot[]{}
\refoot[]{}
\lofoot[]{}
\cofoot[]{}
\rofoot[]{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% variables for name, subtitle and tag line
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\subtit}[1]{\def\@subtit{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BODY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\@namefontheight}
\newlength{\@namelineheight}
\settoheight{\@namefontheight}{\Huge\bfseries\MakeUppercase{A}}
\setlength\@namelineheight{1.5\@namefontheight}

% assemble the header
\newcommand{\makeheader}{% header bar is a minipage
    \begin{minipage}[t][\headerheight]{\textwidth}%
        \vspace{\dimexpr \@namefontheight-\@namelineheight}%
          \begin{minipage}[t][\dimexpr \headerheight-2em-\marginbottom]{\linewidth}
            \begin{flushleft}%
              {\huge\bfseries\color{headerfontcolor}\MakeUppercase{\@name}}%
            \end{flushleft}%
          \end{minipage}
           % print the subtitle
          \begin{minipage}[t][\dimexpr \headerheight-2em-\marginbottom]{\linewidth}%
            \begin{flushright}%
              {\normalsize\bfseries\color{headerfontcolor}\@subtit}%
            \end{flushright}%
          \end{minipage}%
          %\vfill%
    \end{minipage}%
    \vfill%
    %\hspace{0.5cm}%
}

\newcommand{\emptyheader}{%
    \vspace*{\dimexpr \headerheight+0.5em}
}

\newcommand{\infofield}[2]{\mbox{\makebox[5mm]{\textcolor{accent}{\normalsize #1}}\hspace{0.5em}#2}\vspace{0.2em}\newline}
\newcommand{\email}[1]{\infofield{\faEnvelope}{\href{mailto:#1.com}{#1}}}
\newcommand{\address}[1]{\infofield{\faAt}{#1}}
\newcommand{\location}[2]{\infofield{\faMapMarker}{\href{#2}{#1}}}
\newcommand{\phone}[1]{\infofield{\faPhone}{\href{tel:#1}{#1}}}
\newcommand{\homepage}[2]{\infofield{\faHome}{\href{#2}{#1}}}
\newcommand{\linkedin}[2]{\infofield{\faLinkedin}{\href{#2}{#1}}}
\newcommand{\github}[2]{\infofield{\faGithub}{\href{#2}{#1}}}
\newcommand{\orcid}[2]{\infofield{\aiOrcid}{\href{#2}{#1}}}
\newcommand{\ads}[2]{\infofield{\aiADS}{\href{#2}{#1}}}


% highlight bar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\highlightbar}[1]{%
    \def\@highlightbar{%
        \begin{minipage}[t]{\dimexpr \highlightwidth-\marginleft-\marginright}%
            #1%
        \end{minipage}%
    }
}

% main bar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\mainbar}[1]{%
    \def\@mainbar{%
        \begin{minipage}[t]{\dimexpr \textwidth-\highlightwidth}%
          \vspace*{\dimexpr \@namefontheight-\@namelineheight+.3cm}%
        \begin{center}%
          \normalsize%
          \textit{\color{emphasis}\@tagline}%
        \end{center}%
        \bigskip%
            #1%
        \end{minipage}%
    }
}

% make body with highlight bar and main bar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makebody}{%
    \ifthenelse{\boolean{@singleordouble}}
        {% if single layout, the highlight bar is always left
            \@highlightbar
            \hspace{\dimexpr \marginleft+\marginright}%
            \@mainbar
        }{% if double layout, the highlight bar alternates
            \Ifthispageodd{% if the page is odd, the highlight bar is on the left (as is for single layout)
                \@highlightbar
                \hspace{\dimexpr \marginleft+\marginright}%
                \@mainbar
            }{%  if the page is even, the highlight bar is on the right
                \@mainbar
                \hspace{\dimexpr \marginleft+\marginright}%
                \@highlightbar
            }   
        }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTIONS, SUBSECTIONS, AND MORE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% redefine section in caps, bold and with rule below
\renewcommand{\section}[2][]{%
    \ifstrequal{#1}{}{}{\large \makebox[5mm][c]{#1}\hspace{0.5em}}%
    {\color{heading}\Large\bfseries\MakeUppercase{#2}}%

    {\color{heading}\rule{\linewidth}{0.5pt}}%
}

% redefine subsection as bold
\renewcommand{\subsection}[1]{%
  {\color{emphasis}\large\bfseries{#1}}%
  \smallskip%
}

% format job/school list
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set length of date/place column versus position column in fraction of linewidth before linewidth gets redefined in minipages
% 1=date, 2=company/location 3=position
\newlength{\jobdatelength}
\newlength{\jobplacelength}
\newlength{\jobpositionlength}
\setlength{\jobplacelength}{.65\linewidth}
\setlength{\jobdatelength}{.35\linewidth}
\setlength{\jobpositionlength}{\linewidth}
\newcommand{\job}[3]{%
  \begin{flushleft}
    \begin{minipage}[t]{\linewidth}% minipage for left column with date/place
      \large%
      \begin{minipage}[t]{\dimexpr \jobplacelength}% Job location
        \begin{minipage}[t]{5mm}% wrap marker in minipage to allow multi-line places
              \makebox[5mm][c]{\faMapMarker}%
        \end{minipage}%
        \hspace{0.5em}%
        {\large \color{accent} \bfseries\MakeUppercase{#2}}%
      \end{minipage}%
      \begin{minipage}[t]{\dimexpr \jobdatelength+\marginright+4mm}% minipage for date
        \begin{flushright}%
          {\normalsize #1}%
          \hspace{\dimexpr 0.5em+1mm}%
          \begin{minipage}[t]{5mm}% wrap marker in minipage to allow multi-line dates
              \makebox[5mm][c]{\faCalendar}%
          \end{minipage}%
        \end{flushright}%
      \end{minipage}%
    \end{minipage}%

    \begin{minipage}[t]{\dimexpr \jobpositionlength+4mm}% Position
      \hspace{\dimexpr 0.5em + 5mm}%
      {\normalsize \MakeUppercase{#3}}%
    \end{minipage}%
  \end{flushleft}%
}

% Start a job's job description section
\newcommand{\jobdescriptionstart}{%
    \begin{minipage}[t]{\dimexpr \linewidth}%
      \begin{flushleft}%
        \begin{itemize}[leftmargin=1.1cm]%
          \small%
}

% End a job's job description section
\newcommand{\jobdescriptionend}{%
        \end{itemize}
      \end{flushleft}%
    \end{minipage}%
    \normalsize%

}

% Job Description Entry
\newcommand{\jobdescriptionentry}[1]{%
        \item[\ding{59}] #1

}
\newlength{\schooldatelength}
\newlength{\schoolplacelength}
\newlength{\schoolpositionlength}
\setlength{\schooldatelength}{0.5\linewidth}
\setlength{\schoolplacelength}{0.5\linewidth}
\setlength{\schoolpositionlength}{0.5\linewidth}

% Education
% 1=date 2=place 3=position
\newcommand{\school}[3]{%
    \begin{minipage}[t]{\schooldatelength}% minipage for left column with date/place
        \large
        \begin{minipage}[t]{5mm}% wrap marker in minipage to allow multi-line dates
            \makebox[5mm][c]{\faCalendar}
        \end{minipage}%
        \hspace{\dimexpr 0.5em}%
        \begin{minipage}[t]{\dimexpr \schooldatelength-5mm-0.5em}% wrap date in minipage to allow multi-line dates
          {\large #1}
        \end{minipage}%

        \vspace*{0mm}%
        \begin{minipage}[t]{5mm}% wrap marker in minipage to allow multi-line places
            \makebox[5mm][c]{\faMapMarker}
        \end{minipage}%
        \hspace{0.5em}%
        \begin{minipage}[t]{\dimexpr \schoolplacelength-5mm-0.5em}% wrap place in minipage to allow multi-line places
        \vspace*{-3mm}%
        {\large \color{accent}\bfseries\MakeUppercase{#2}}
        \end{minipage}%
    \end{minipage}%
    \begin{minipage}[t]{\dimexpr \schoolpositionlength+\marginright+4mm}% minipage for position
      \begin{flushright}
        {\large #3}
      \end{flushright}
    \end{minipage}%
    \vspace{.2cm}%
}


% skill 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\simpleskill}[1]{%
  {\textcolor{emphasis}\normalsize#1}
}

% sectioning of skills
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\skillsection}[1]{%
  {\color{accent}\large{#1}}

}

% for job description entries
\RequirePackage{enumitem}
\setlist[itemize]{noitemsep, topsep=0pt, leftmargin=1em}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FINAL FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\pagestyle{headerhighlightmain}
\RequirePackage{hyperref}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  THE END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
