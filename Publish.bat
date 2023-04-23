@echo off

rem ------------------------------------
rem Build solution.
echo Building NotionPublisher solution...
dotnet build -c Release
rem ------------------------------------
rem Delete dev files.
echo Deleting dev files...
set target_ext=.pdb
set target_json=appsettings.Development.json
set npapi_rel_dir=.\RedmineApi\bin\Release\net6.0
set rmlder_rel_dir=.\RedmineLoader\bin\Release\net6.0
set ntpub_rel_dir=.\RedminePublisher\bin\Release\net6.0
del /q /s "%npapi_rel_dir%\*%target_ext%"
del /q /s "%npapi_rel_dir%\%target_json%"
del /q /s "%rmlder_rel_dir%\*%target_ext%"
del /q /s "%rmlder_rel_dir%\%target_json%"
del /q /s "%ntpub_rel_dir%\*%target_ext%"
del /q /s "%ntpub_rel_dir%\%target_json%"
rem ------------------------------------
rem Copy dockerfile to release directory.
echo Copying dockerfiles to release directories...
set npapi_dodckerfile=.\jenkins\RedmineApiDockerFile
set rmlder_dodckerfile=.\jenkins\RedmineLoaderDockerFile
set ntpub_dodckerfile=.\jenkins\RedminePublisherDockerFile
copy /y "%npapi_dodckerfile%" "%npapi_rel_dir%\Dockerfile"
copy /y "%rmlder_dodckerfile%" "%rmlder_rel_dir%\Dockerfile"
copy /y "%ntpub_dodckerfile%" "%ntpub_rel_dir%\Dockerfile"