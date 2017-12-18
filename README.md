# Course: Data storage | Data collection | Data management

### Introduction

This are the companion lectures for the course "Data storage, data collection and data management" at the University of Freiburg.
<hr>
You can create a new Project in RStudio, directly from git. Just set the correct url, select a local path and open the project. You will
find all lectures as `.md` or `.Rmd` files in the lectures folder. The exercises are listed in the table at the very end of this document.<br>
<div class="alert alert-info">
If you want to make your exercise solution available to everyone, [fork this project in GitHub](https://github.com/modche/datacourse2018). Then, replace `modche` with your git-username while creating the RStudio project. Commit changes to your copy into a new created folder `WS18/yourname`. Your soulution can be merged into the main project by a pull request. The lecturers will review your changes for giving you a detailed feedback on your solutions.
</div>

### Requirements
For the time series / climate data analysis part following software/resources are needed:
<ul>
  <li><b>R Studio</b> (with Internet access, R Markdown resources like knitr, latex...)</li>
  <li><b>R packages</b> (not complete): tidyverse, viridis, broom, lubridate</li>
  <li><b>Texteditor</b> (normal TextEdit is enough, but you can look for more advanced editors)</li>
  <li>MS Excel (sometimes), MS Word or word processor (to write report)</li>
</ul>
<ul>
  <li><b>Basic R knowledge</b> (read/write data, plotting, install packages, R Studio handling, basic statistics with R)</li>
  <li><b>Internet access</b> is really important (eduroam Wi-Fi).</li>
</ul>
<hr>
For the (Geo)-databases part the following software is needed:
<ul>
  <li><b>QGIS</b> version 2.14 or 2.18 (<a href="https://qgis.org/de/site/forusers/download.html" target="_blank">https://qgis.org/de/site/forusers/download.html</a>). QGIS is available for Windows, Mac and Linux.</li>
</ul>
<br>
On top you will need a software for managing PostgreSQL database servers. There are two options:
<ul>
  <li><b>pgAdminIII</b> (Caution: not pgAmin4!!!!). For Windows/Mac:&nbsp;<a href="https://www.pgadmin.org/download/" target="_blank">https://www.pgadmin.org/download/</a>&nbsp;; Linux userswill find pgAdminIII in the software repositories&nbsp;of Debian, Ubuntu, CentOS/Redhat/Fedora and OpenSuse, always called 'pgadmin3'</li>
  <li><b>DataGrip: </b>This is the preferred software, but it is a proprietary chargeable software. For students it is free, in case you register using a university mail adress. DataGrip is available for Windows, Mac and Linux.&nbsp;</li>
</ul><br>
DataGrip is way more powerful than pgAdmin, but not open Source. You can accomplish the lecture with both products.<br><br>
Furthermore a Github (<a href="https://github.com/" target="_blank">https://github.com</a>)&nbsp;Account is of great advantage. If you do not yet have an account, you can register immediately. Independent of this lecture the usage of github or any other VCS (Version Control system) is highly recommended. A more or less professional usage of R is hardly imaginable without VCS. The usage of git will be introduced very quickly in the second week.

### Exercises

|           exercise         | topic |                        link                              |       mandatory         |
| -------------------------- |:-----:|:--------------------------------------------------------:|:-----------------------:|
| Exercise 2 |   1   | [Exercise_Index.md](Exercise_Index.md) | <span class="glyphicon glyphicon-ok" style="color:green"></span> |
| SQL introduction | 4 | [SQL introduction](exercises/sql_exercises.Rmd) | <span class="glyphicon glyphicon-ok" style="color:green"></span> |
| N.A. | N.A. | [dead link](exercises/file.Rmd) | <span class="glyphicon glyphicon-remove" style="color:red"></span> |