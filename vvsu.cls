% V 3.1
% Author: Mark Vodyanitskiy (@mvodya) 2023
% СК-СТО-ТР-04-1.005-2015
% Основано на требовании к оформлению текстовой части выпускных
% квалификационных работ, курсовых работ (проектов), рефератов,
% контрольных работ, отчетов по практикам, лабораторных работ

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vvsu}[2023/05/17 VVSU CTO 04-1-005-2015]

% Base class
\LoadClass[a4paper,12pt,oneside]{scrartcl}

% Base packages
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{float}
\RequirePackage{hyperref}

% Общие настройки
\RequirePackage[left=3cm,right=1cm,top=2cm,bottom=2cm,bindingoffset=0cm]{geometry}
\RequirePackage[english,russian]{babel}
\RequirePackage{fontspec}
\RequirePackage{indentfirst}
\RequirePackage{hyphenat}
\setmainfont{Times New Roman}
\renewcommand{\baselinestretch}{1.5}
\setlength{\parindent}{1.25cm}
\setlength{\parskip}{0cm}
\setlength{\intextsep}{6pt plus 0pt minus 4pt}
\spaceskip=2\fontdimen2\font plus 2\fontdimen3\font minus 2\fontdimen4\font
\clubpenalty=10000
\widowpenalty=10000
%\brokenpenalty=10000

% Настройка подписей
\RequirePackage[labelsep=endash]{caption}

% Настройки списков
\RequirePackage{enumitem}
% \setlist[enumerate]{label=\theenumi), leftmargin=0cm, labelwidth=*, itemindent=\dimexpr\labelwidth+\parindent-\labelsep, itemsep=0cm, topsep=0cm, parsep=0cm}
\newenvironment{vvsu_list}{
  \begin{enumerate}[label=\theenumi), leftmargin=0cm, labelwidth=*, itemindent=\dimexpr\labelwidth+\parindent-\labelsep, itemsep=0cm, topsep=0cm, parsep=0cm]
}{
  \end{enumerate}
}

% Настройки таблиц
\newenvironment{vvsu_table}[2][H]{
  \begin{table}[#1]
  \captionsetup{singlelinecheck=off, position=top, skip=0cm}
  \caption{#2}
}{
  \end{table}
}

% Настройки картинок
\NewDocumentEnvironment{vvsu_figure}{ m O{H} m }{
  \begin{figure}[#2]
  \captionsetup{position=bottom, skip=0cm, justification=centering, parskip=0cm, name=Рисунок}
  \centering
}{
  \caption{#1}
  \label{#3}
  % \vspace{-12pt}
  \end{figure}
}


% Настройки нумерации страниц
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyheadoffset{0cm}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\topmargin=-1.29cm % 1.25cm - 2.54cm (1in)
\headsep=12pt
\fancyhead[R]{\thepage}
\fancypagestyle{plain}{%
   \fancyhf{}%
   \fancyhead[R]{\thepage}%
}

% Счетчик для пропуска страниц
% используется для сохранения страницы с последующим декрементом
\newcounter{pageskipcnt}

% Настройка содержания
\RequirePackage{tocloft}
\renewcommand{\cftdotsep}{1}
\renewcommand{\cftpartleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand\cftpartafterpnum{}
\renewcommand\cftsecafterpnum{}
\renewcommand\cftsubsecafterpnum{}
\renewcommand{\cftpartfont}{}
\renewcommand{\cftsecfont}{}
\renewcommand{\cftsubsecfont}{}
\renewcommand{\cftpartpagefont}{}
\renewcommand{\cftsecpagefont}{}
\renewcommand{\cftsubsecpagefont}{}
\renewcommand\cftsecnumwidth{0.5cm}
\renewcommand\cftsubsecnumwidth{0.8cm}
\renewcommand{\cftbeforesecskip}{-0.3em}

% Функции для записи участников
\RequirePackage{tabularx}
\RequirePackage{forloop}
\newcounter{membercnt}
\def\member#1#2{\expandafter\def\csname MEM-A-\themembercnt\endcsname{#1}%
\expandafter\def\csname MEM-B-\themembercnt\endcsname{#2}\stepcounter{membercnt}}
\def\getmemberA#1{\csname MEM-A-#1\endcsname}
\def\getmemberB#1{\csname MEM-B-#1\endcsname}
\newcounter{memberq}

% Год
\newcommand{\vvsuyear}{2020}

% ТИТУЛЬНЫЙ ЛИСТ
\renewcommand{\maketitle}{%
  % Заголовок
  {\centering МИНОБРНАУКИ РОССИИ\\
  ВЛАДИВОСТОКСКИЙ ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ\\
  ИНСТИТУТ ИНФОРМАЦИОННЫХ ТЕХНОЛОГИЙ\\
  КАФЕДРА ИНФОРМАЦИОННЫХ ТЕХНОЛОГИЙ И СИСТЕМ\\}%
  \vfill
  % Название
  {\centering\fontsize{24}{24}\linespread{1}\selectfont\MakeUppercase{\@title}\\}%
  \vfill
  % Участники
  {\linespread{1}\selectfont
  \begin{tabularx}{\textwidth}{lXX}%
  \forloop{memberq}{0}{\value{memberq} < \themembercnt}{%
    \noindent\getmemberA{\thememberq} & \hrulefill & \getmemberB{\thememberq}\vspace{5pt}\\
  }
  \end{tabularx}%
  }
  \vfill
   % Футер
  {\centering Владивосток \vvsuyear \\}%
  \thispagestyle{empty}%
  \clearpage
}

% Дополнительная страница до содержания (нап. Задание)
% Не идет в подсчет страниц
\newenvironment{addition}[1] {
  \pagestyle{empty}
  \setcounter{pageskipcnt}{\value{page}}
  {\centering\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont#1\vspace{8pt}\\}
  }{
  \clearpage
  \setcounter{page}{\value{pageskipcnt}}
  \pagestyle{fancy}
}

% СОДЕРЖАНИЕ
% Не идет в подсчет страниц
\newcommand{\toc} {
  \pagestyle{empty}
  \setcounter{pageskipcnt}{\value{page}}
  {\centering\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont Содержание\vspace{8pt}\\}
  \@starttoc{toc}%
  \clearpage
  \setcounter{page}{\value{pageskipcnt}}
  \pagestyle{fancy}
}

% ВВЕДЕНИЕ
\newenvironment{introduction} {
  \addcontentsline{toc}{section}{Введение}
  {\centering\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont Введение\vspace{8pt}\\}
  }{
  \clearpage
}

% ЗАКЛЮЧЕНИЕ
\newenvironment{conclusion} {
  \addcontentsline{toc}{section}{Заключение}
  {\centering\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont Заключение\vspace{8pt}\\}
  }{
  \clearpage
}

% Настройки для библиографии (списка источников)
\usepackage[sorting=none]{biblatex}
\DeclareFieldFormat{title}{#1}
\DeclareBibliographyDriver{online}{
  \printfield{title} [Электронный ресурс]
  // \printnames{author}
  - \nohyphens{Режим доступа:} \printfield{howpublished}
  \nohyphens{\printfield{note}}
  \finentry
}
\DeclareFieldFormat{labelnumberwidth}{#1\adddot}
\defbibenvironment{bibliography}
{\list
{\printfield[labelnumberwidth]{labelnumber}}
{\setlength{\labelwidth}{\labelnumberwidth}
\setlength{\leftmargin}{0cm}
\setlength{\labelsep}{0cm}
\setlength{\itemindent}{\dimexpr\labelwidth+\parindent-\labelsep}
\addtolength{\leftmargin}{\labelsep}
\setlength{\itemsep}{0cm}
\setlength{\topsep}{0cm}
\setlength{\parsep}{0cm}}
\renewcommand*{\makelabel}[1]{\hss##1}}
{\endlist}
{\item}
\setcounter{biburlnumpenalty}{100}
% \setcounter{biburlucpenalty}{100}
% \setcounter{biburllcpenalty}{100}
\renewcommand*{\finentrypunct}{}

% СПИСОК ИСТОЧНИКОВ
\newcommand{\references} {
  \clearpage
  \addcontentsline{toc}{section}{Список использованных источников}
  {\centering\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont Список использованных источников\vspace{8pt}\\}
  \printbibliography[heading=none]
}

% ГЛАВА
\renewcommand\section{
  \@startsection {section}{1}{\parindent}%
  {12pt}%
  {14pt}%
  {\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont}
}

% ПОДГЛАВА
\renewcommand\subsection{
  \@startsection {subsection}{2}{\parindent}%
  {20pt}%
  {8pt}%
  {\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont}
}