% V 5.9
% Author: Mark Vodyanitskiy (@mvodya) 2024
% СК-СТО-ТР-04-1.005-2015
% Основано на требовании к оформлению текстовой части выпускных
% квалификационных работ, курсовых работ (проектов), рефератов,
% контрольных работ, отчетов по практикам, лабораторных работ

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vvsu}[2024/06/21 VVSU CTO 04-1-005-2015]

% Base class
\LoadClass[a4paper,12pt,oneside]{scrartcl}

% Base packages
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{float}
\RequirePackage{hyperref}
\RequirePackage{xassoccnt}
\RequirePackage{xstring}
\RequirePackage{varwidth}

% Общие настройки
\RequirePackage[left=3cm,right=1cm,top=2cm,bottom=2cm,bindingoffset=0cm]{geometry}
\RequirePackage[english,russian]{babel}
\RequirePackage{fontspec}
\RequirePackage{indentfirst}
\RequirePackage{hyphenat} % Автоматические переносы слов (СТО 4.1.5)
\setmainfont{Times New Roman}
\renewcommand{\baselinestretch}{1.5}
\setlength{\parindent}{1.25cm}
\setlength{\parskip}{0cm}
\setlength{\intextsep}{6pt plus 0pt minus 4pt}
\spaceskip=2\fontdimen2\font plus 2\fontdimen3\font minus 2\fontdimen4\font
\clubpenalty=10000
\widowpenalty=10000
%\brokenpenalty=10000
\RequirePackage{url}
\urlstyle{same} % Фикс шрифта для URL

% Настройка подписей
\RequirePackage[labelsep=endash]{caption}

% Настройки списков
\RequirePackage{enumitem}
\newenvironment{vvsu_list}{
  \begin{enumerate}[label=\theenumi), itemsep=0cm, topsep=0cm, parsep=0cm, wide=\parindent]
}{
  \end{enumerate}
}

% Настройки таблиц
\NewTotalDocumentCounter{cnttotaltables}
\newenvironment{vvsu_table}[2][H]{
  \begin{table}[#1]
  \captionsetup{singlelinecheck=off, position=top, skip=0cm}
  \addtocounter{cnttotaltables}{1}\caption{#2}
}{
  \end{table}
}
% Вывод общего количества таблиц
\newcommand{\totaltables}{\TotalValue{cnttotaltables}}
% Макрос для плюризации слова "таблица"
\newcommand{\declinetable}[1]{%
  \StrRight{#1}{2}[\lastTwoDigits]%
  \StrRight{#1}{1}[\lastDigit]%
  \IfInteger{\lastTwoDigits}{%
    \ifthenelse{\(\lastTwoDigits > 10\) \AND \(\lastTwoDigits < 20\)}{%
      #1~таблиц%
    }{%
      \IfStrEq{\lastDigit}{1}{%
        #1~таблица%
      }{%
        \IfStrEq{\lastDigit}{2}{%
          #1~таблицы%
        }{%
          \IfStrEq{\lastDigit}{3}{%
            #1~таблицы%
          }{%
            \IfStrEq{\lastDigit}{4}{%
              #1~таблицы%
            }{%
              #1~таблиц%
            }%
          }%
        }%
      }%
    }%
  }{#1~таблиц}%
}
% Вывод общего количества таблиц с плюризацией
\newcommand{\printtotaltables}{\declinetable{\TotalValue{cnttotaltables}}}
% Макрос для плюризации слова "table"
\newcommand{\declinetableeng}[1]{%
  \StrRight{#1}{1}[\lastDigit]%
  \IfInteger{#1}{%
    \ifthenelse{#1 = 1}{%
      #1~table%
    }{%
      #1~tables%
    }%
  }{#1~tables}%
}
% Вывод общего количества таблиц с плюризацией на английском
\newcommand{\printtotaltableseng}{\declinetableeng{\TotalValue{cnttotaltables}}}

% Настройки картинок
\NewTotalDocumentCounter{cnttotalfigures}
\NewDocumentEnvironment{vvsu_figure}{ m O{H} m }{
  \begin{figure}[#2]
  \vspace{6pt} % Добавляем отступ 6pt перед рисунком (СТО: п.5.3.7)
  \captionsetup{position=bottom, skip=0cm, justification=centering, parskip=0cm, name=Рисунок}
  \centering
  \centering
  }{
  \begin{minipage}{0.95\linewidth} % Ограничиваем максимальную ширину (фикс бага отступами для подписей)
  \addtocounter{cnttotalfigures}{1}\caption{#1}
  \label{#3}
  \end{minipage}
  \vspace{-6pt}
  \end{figure}
}
% Вывод общего количества изображений
\newcommand{\totalfigures}{\TotalValue{cnttotalfigures}}
% Макрос для плюризации слова "изображений"
\newcommand{\declinefigure}[1]{%
  \StrRight{#1}{2}[\lastTwoDigits]%
  \StrRight{#1}{1}[\lastDigit]%
  \IfInteger{\lastTwoDigits}{%
    \ifthenelse{\(\lastTwoDigits > 10\) \AND \(\lastTwoDigits < 20\)}{%
      #1~изображений%
    }{%
      \IfStrEq{\lastDigit}{1}{%
        #1~изображение%
      }{%
        \IfStrEq{\lastDigit}{2}{%
          #1~изображения%
        }{%
          \IfStrEq{\lastDigit}{3}{%
            #1~изображения%
          }{%
            \IfStrEq{\lastDigit}{4}{%
              #1~изображения%
            }{%
              #1~изображений%
            }%
          }%
        }%
      }%
    }%
  }{#1~изображений}%
}
% Вывод общего количества изображений с плюризацией
\newcommand{\printtotalfigures}{\declinefigure{\TotalValue{cnttotalfigures}}}
% Макрос для плюризации слова "image"
\newcommand{\declineimageeng}[1]{%
  \ifthenelse{#1 = 1}{%
    #1~image%
  }{%
    #1~images%
  }%
}
% Вывод общего количества изображений с плюризацией на английском
\newcommand{\printtotalfigureseng}{\declineimageeng{\TotalValue{cnttotalfigures}}}


% Настройки нумерации страниц
\RequirePackage{fancyhdr}
\NewTotalDocumentCounter{reallastpagenumber}
\pagestyle{fancy}
\fancyhf{}
\fancyheadoffset{0cm}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\topmargin=-1.29cm % 1.25cm - 2.54cm (1in)
\headsep=12pt
\fancyhead[R]{\setcounter{reallastpagenumber}{\numexpr\thepage+1\relax}
\thepage}
\fancypagestyle{plain}{%
   \fancyhf{}%
   \fancyhead[R]{\thepage}%
}
% Вывод общего количества страниц
\newcommand{\totalpages}{\TotalValue{reallastpagenumber}}
% Макрос для плюризации слова "страница"
\newcommand{\declinepage}[1]{%
  \StrRight{#1}{2}[\lastTwoDigits]%
  \StrRight{#1}{1}[\lastDigit]%
  \IfInteger{\lastTwoDigits}{%
    \ifthenelse{\(\lastTwoDigits > 10\) \AND \(\lastTwoDigits < 20\)}{%
      #1~страниц%
    }{%
      \IfStrEq{\lastDigit}{1}{%
        #1~страница%
      }{%
        \IfStrEq{\lastDigit}{2}{%
          #1~страницы%
        }{%
          \IfStrEq{\lastDigit}{3}{%
            #1~страницы%
          }{%
            \IfStrEq{\lastDigit}{4}{%
              #1~страницы%
            }{%
              #1~страниц%
            }%
          }%
        }%
      }%
    }%
  }{#1~страниц}%
}
% Вывод общего количества страниц с плюризацией
\newcommand{\printtotalpages}{\declinepage{\TotalValue{reallastpagenumber}}}
% Макрос для плюризации слова "page"
\newcommand{\declinepageeng}[1]{%
  \ifthenelse{#1 = 1}{%
    #1~page%
  }{%
    #1~pages%
  }%
}
% Вывод общего количества страниц с плюризацией на английском
\newcommand{\printtotalpageseng}{\declinepageeng{\TotalValue{reallastpagenumber}}}

% Счетчик для пропуска страниц
% используется для сохранения страницы с последующим декрементом
\newcounter{pageskipcnt}

% Настройка содержания
% СТО: Приложение Г
\RequirePackage{tocloft}
\renewcommand{\cftdotsep}{1}
\renewcommand{\cftpartleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftpartafterpnum}{}
\renewcommand{\cftsecafterpnum}{}
\renewcommand{\cftpartafterpnum}{}
\renewcommand{\cftsubsecafterpnum}{}
\renewcommand{\cftpartfont}{}
\renewcommand{\cftsecfont}{}
\renewcommand{\cftsubsecfont}{}
\renewcommand{\cftsubsubsecfont}{}
\renewcommand{\cftpartpagefont}{}
\renewcommand{\cftsecpagefont}{}
\renewcommand{\cftsubsecpagefont}{}
\renewcommand{\cftsubsubsecpagefont}{}
% Отступ для Введение, Заключение и т.п.
\renewcommand{\cftpartindent}{0.5cm}
% Отступы для уровней списка
\renewcommand{\cftsecindent}{0cm}
\renewcommand{\cftsubsecindent}{0.5cm}
\renewcommand{\cftsubsubsecindent}{1.3cm}
% Отступы для цифр
\renewcommand{\cftpartnumwidth}{0cm}
\renewcommand{\cftsecnumwidth}{0.5cm}
\renewcommand{\cftsubsecnumwidth}{0.8cm}
\renewcommand{\cftsubsubsecnumwidth}{1.1cm}
% Фикс пробелов между главами
\renewcommand{\cftbeforepartskip}{0.5em}
\renewcommand{\cftbeforesecskip}{0.5em}
\renewcommand{\cftbeforesubsecskip}{0.5em}
\renewcommand{\cftbeforesubsubsecskip}{0.5em}
% Управление межстрочным интервалом
\pretocmd{\l@part}{\linespread{1}\selectfont}{}{\error}
\apptocmd{\l@part}{\linespread{1.5}\selectfont}{}{\error}
\pretocmd{\l@section}{\linespread{1}\selectfont}{}{\error}
\apptocmd{\l@section}{\linespread{1.5}\selectfont}{}{\error}
\pretocmd{\l@subsection}{\linespread{1}\selectfont}{}{\error}
\apptocmd{\l@subsection}{\linespread{1.5}\selectfont}{}{\error}
\pretocmd{\l@subsubsection}{\linespread{1}\selectfont}{}{\error}
\apptocmd{\l@subsubsection}{\linespread{1.5}\selectfont}{}{\error}

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
\newcommand{\vvsuyear}[1]{\gdef\@vvsuyear{#1}}
\newcommand{\@vvsuyear}{2024}

% Подзаголовок
\renewcommand{\subtitle}[1]{\gdef\@subtitle{#1}}

% Шапка
\newcommand{\vvsuhead}[1]{\gdef\@vvsuhead{#1}}
\newcommand{\@vvsuhead}{\linespread{1}\selectfont{}МИНОБРНАУКИ РОССИИ\\
\vspace{10pt}Федеральное государственное бюджетное образовательное учреждение\\
высшего образования\\
\fontsize{13}{13}\selectfont{}<<ВЛАДИВОСТОКСКИЙ ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ>>\\
(ФГБОУ ВО <<ВВГУ>>)\\
\vspace{10pt}\fontsize{12}{12}\selectfont{}ИНСТИТУТ ИНФОРМАЦИОННЫХ ТЕХНОЛОГИЙ И АНАЛИЗА ДАННЫХ\\
КАФЕДРА ИНФОРМАЦИОННЫХ ТЕХНОЛОГИЙ И СИСТЕМ}

% Рекомендация
\newcommand{\featurerecomentation}{0}
\newcommand{\vvsurecommendation}[2]{\renewcommand{\featurerecomentation}{1}\gdef\@recomrole{#1}\gdef\@recomname{#2}}

% Код работы
\newcommand{\featurecode}{0}
\newcommand{\vvsucode}[1]{\renewcommand{\featurecode}{1}\gdef\@vvsucode{#1}}

% ТИТУЛЬНЫЙ ЛИСТ
\renewcommand{\maketitle}{%
  % Шапка
  {\centering\fontsize{14}{14}\linespread{1.5}\selectfont\@vvsuhead\\}%
  % Блок для рекомендации
  \ifnum\featurerecomentation=1\relax%
  {\vfill%
  \begin{flushright}%
    \begin{varwidth}{.4\textwidth}%
      \centering\fontsize{12}{12}\selectfont
      \uppercase{Рекомендовано}\\
      к защите\\
      \ifx\@recomrole\@empty\else%
      \@recomrole\\
      \fi%
      \hrulefill{} \@recomname
    \end{varwidth}%
  \end{flushright}}%
  \fi%
  \vfill%
  % Заголовок
  {\centering\fontsize{24}{24}\linespread{1}\selectfont\MakeUppercase{\@title}\\}%
  % Текст под названием (например название работы)
  \ifx\@subtitle\@empty\else%
    {\vspace{14pt}\centering\fontsize{22}{22}\linespread{1}\selectfont{\@subtitle}\\}%
  \fi%
  % Код работы
  \ifnum\featurecode=1%
    {\vspace{4pt}\centering\fontsize{22}{22}\linespread{1}\selectfont{\@vvsucode}\\}%
  \fi%
  \vfill%
  % Участники
  {\linespread{1}\selectfont
  \noindent\begin{tabularx}{\textwidth}{lXl}%
  \forloop{memberq}{0}{\value{memberq} < \themembercnt}{%
    \noindent\getmemberA{\thememberq} & \hrulefill & \getmemberB{\thememberq}\vspace{5pt}\\
  }
  \end{tabularx}}%
  \vfill%
   % Футер
  {\centering Владивосток \@vvsuyear \\}%
  \thispagestyle{empty}%
  \clearpage%
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

% Дополнительная страница до содержания БЕЗ ЗАГОЛОВКОВ (свое оформление)
% Не идет в подсчет страниц
\newenvironment{empty_addition} {
  \pagestyle{empty}
  \setcounter{pageskipcnt}{\value{page}}
  }{
  \clearpage
  \setcounter{page}{\value{pageskipcnt}}
  \pagestyle{fancy}
}

% СОДЕРЖАНИЕ
\newcommand{\toc} {
  {\centering\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont Содержание\vspace{8pt}\\}
  \@starttoc{toc}%
  \clearpage
}

% ВВЕДЕНИЕ
\newenvironment{introduction} {
  \addcontentsline{toc}{part}{Введение}
  {\centering\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont Введение\vspace{8pt}\\}
  }{
  \clearpage
}

% ЗАКЛЮЧЕНИЕ
\newenvironment{conclusion} {
  \addcontentsline{toc}{part}{Заключение}
  {\centering\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont Заключение\vspace{8pt}\\}
  }{
  \clearpage
}

% Настройки для библиографии (списка источников)
\RequirePackage[sorting=none]{biblatex}
\NewTotalDocumentCounter{cnttotalreferences}
\DeclareFieldFormat{title}{#1}
\DeclareBibliographyDriver{online}{
  \addtocounter{cnttotalreferences}{1}
  \printfield{title} [Электронный ресурс]
  // \printnames{author}
  − \nohyphens{Режим доступа:} \printfield{howpublished}
  \nohyphens{\printfield{note}}
  \finentry
}
\DeclareBibliographyDriver{misc}{
  \addtocounter{cnttotalreferences}{1}
  \printfield{title}; \printfield[noformat]{eprint} (\printfield{year}) [Статья]
  // \printnames{author}
  \nohyphens{\printfield{note}}
  \finentry
}
\DeclareFieldFormat{labelnumberwidth}{#1} % было #1\adddot, но по СТО: п.4.9.2
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
% Вывод общего количества источников
\newcommand{\totalreferences}{\TotalValue{cnttotalreferences}}
% Макрос для плюризации слова "источник"
\newcommand{\declinereference}[1]{%
  \StrRight{#1}{2}[\lastTwoDigits]%
  \StrRight{#1}{1}[\lastDigit]%
  \IfInteger{\lastTwoDigits}{%
    \ifthenelse{\(\lastTwoDigits > 10\) \AND \(\lastTwoDigits < 20\)}{%
      #1~источников%
    }{%
      \IfStrEq{\lastDigit}{1}{%
        #1~источник%
      }{%
        \IfStrEq{\lastDigit}{2}{%
          #1~источника%
        }{%
          \IfStrEq{\lastDigit}{3}{%
            #1~источника%
          }{%
            \IfStrEq{\lastDigit}{4}{%
              #1~источника%
            }{%
              #1~источников%
            }%
          }%
        }%
      }%
    }%
  }{#1~источников}%
}
% Вывод общего количества источников с плюризацией
\newcommand{\printtotalreferences}{\declinereference{\TotalValue{cnttotalreferences}}}
% Макрос для плюризации слова "reference"
\newcommand{\declinereferenceeng}[1]{%
  \ifthenelse{#1 = 1}{%
    #1~reference%
  }{%
    #1~references%
  }%
}
% Вывод общего количества источников с плюризацией на английском
\newcommand{\printtotalreferenceseng}{\declinereferenceeng{\TotalValue{cnttotalreferences}}}


% СПИСОК ИСТОЧНИКОВ
\newcommand{\references} {
  \clearpage
  \addcontentsline{toc}{part}{Список использованных источников}
  {\centering\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont Список использованных источников\vspace{8pt}\\}
  \printbibliography[heading=none]
}

% ГЛАВА
\renewcommand\section{%
  \@startsection {section}{1}{\parindent}%
  {0pt}%
  {12pt}%
  {\fontsize{14}{14}\linespread{1}\setmainfont{Arial}\selectfont}%
}

% ПОДГЛАВА
\renewcommand\subsection[1]{%
  \@startsection {subsection}{2}{\parindent}%
  {12pt}%
  {0pt}%
  {\fontsize{13}{13}\linespread{1}\setmainfont{Arial}\selectfont}%
  {#1}%
  {\noindent}%
  % Если в названии много строк - отступ 9пт, если одна строка - отступ 6пт (СТО: п.4.5.6)
  % про 6пт - СТО: 4.7.12
  \vspace{\ifdim\dimexpr\fontcharht\font`\A * \numexpr \prevgraf + 1 \relax > \dimexpr 1\baselineskip 9pt\else 6pt\fi}%
}

% ПОДПОДГЛАВА
\renewcommand{\subsubsection}[1]{%
  \@startsection {subsubsection}{3}{\parindent}%
  {0pt}%
  {0pt}%
  {\fontsize{12}{12}\linespread{1}\setmainfont{Times New Roman}\selectfont\bfseries}%
  {#1}%
  {\noindent}%
}
