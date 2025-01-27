#!/bin/bash
# Descricao: Script facilitador de instalacao de aplicativos do fiscal
# Autor: Fabiano Henrique
# Data: 18/11/2019

source /opt/projetus/facilitador/funcoes.sh

acao=$1

if [ "$acao" = "DMA BA" ]; then
  cd "$desktop_path"
  rm -Rf DMA*
  cd /opt/projetus/facilitador
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks gdiplus"
  download "http://www.sefaz.ba.gov.br/contribuinte/informacoes_fiscais/declaracoes/download/dma_2012.exe" "$cache_path/dma_2012.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dma_2012.exe"
  sleep 1
  mv "$desktop_path/DMA_2012.desktop" "$desktop_path/Validadores"
  rm -Rf ~.local/share/applications/wine/Programs/Sefaz-BA*

  endInstall
fi

if [ "$acao" = "DCTF" ]; then
  configurarWine32Facilitador
  cd "$desktop_path/Validadores"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks corefonts"
  rm -Rf DCTF*
  download "https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dctf/dctfmensalv3_6.exe" "$cache_path/dctf.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dctf.exe"
  sleep 1
  cp ~/.local/share/applications/wine/Programs/Programas\ RFB/DCTF\ Mensal\ 3.6/DCTF\ Mensal\ 3.6.desktop "$desktop_path/Validadores"
  cd "$desktop_path"
  rm -Rf DCTF*
  rm -Rf ~/.local/share/applications/wine/Programs/Programas\ RFB/

  endInstall
fi

if [ "$acao" = "EFD Contribuições" ]; then
  download "https://servicos.receita.fazenda.gov.br/publico/programas/SpedPisCofinsPVA/EFDContribuicoes_linux_x64-5.0.2.jar" "$cache_path/EFDContribuicoes.jar"
  executar "java -jar $cache_path/EFDContribuicoes.jar"
  sleep 1
  cd "$desktop_path"
  rm -Rf EFD*
  rm -Rf Desinstalar*
  rm -Rf ~/.local/share/applications/EFD*
  rm -Rf ~/.local/share/applications/Desinstalar*
  cp /opt/projetus/facilitador/atalhos/efd-contribuicoes.desktop "$desktop_path/Validadores"

  endInstall
fi

if [ "$acao" = "GIAM TO" ]; then
  configurarWine
  cd "$desktop_path"
  rm -Rf GIAM*
  cd /opt/projetus/facilitador
  download "http://giam.sefaz.to.gov.br/download/Instalargiam10.0_03.01.2022v1.exe" "$cache_path/giamto.exe"
  executar "wine $cache_path/giamto.exe /silent"
  sleep 3
  mv "$desktop_path/GIAM 10.0.desktop" "$desktop_path/Validadores"
  rm -Rf ~.local/share/applications/wine/Programs/GIAM*

  endInstall
fi

if [ "$acao" = "SPED ICMS IPI" ]; then

  download "https://www.receita.fazenda.gov.br/publico/programas/Sped/SpedFiscal/PVA_EFD_linux-3.0.3_x64.jar" "$cache_path/PVA_EFD.jar"
  
  if [ ! -d "/usr/lib/jvm/jre1.8.0_212/bin/java" ]; then
    executar "java -jar $cache_path/PVA_EFD.jar"
  else
    executar "/usr/lib/jvm/jre1.8.0_212/bin/java -jar $cache_path/PVA_EFD.jar"
  fi
  sleep 1
  cd "$desktop_path"
  rm -Rf EFD*
  rm -Rf Desinstalar*
  cp /opt/projetus/facilitador/atalhos/efd-icms-ipi.desktop "$desktop_path/Validadores"

  endInstall
fi

if [ "$acao" = "SEF 2012 PE" ]; then
  configurarWine
  cd "$desktop_path/Validadores"
  rm -Rf SEF2012*
  executar "winetricks gdiplus"
  download "https://www.sefaz.pe.gov.br/Servicos/SEFII/Programas/SEF2012_v1.6.5.00_instalador.exe.zip" "$cache_path/sef2012.zip"
  unzip $cache_path/sef2012.zip -d ./cache
  executar "wine $cache_path/SEF2012_v1.6.5.00_instalador.exe /silent"
  sleep 1
  cp ~/.local/share/applications/wine/Programs/SEFAZ-PE/SEF\ 2012/SEF\ 2012.desktop "$desktop_path/Validadores"
  rm -Rf ~/.local/share/applications/wine/Programs/SEFAZ-PE
  cd "$desktop_path"
  rm -Rf SEF2012*

  endInstall
fi

if [ "$acao" = "SEFAZNET PE" ]; then
  configurarWine
  executar "winetricks gdiplus"
  download "https://www.sefaz.pe.gov.br/Servicos/Programas%20do%20SEFAZnet/SefazNet_v1.24.0.3_instalador.exe.zip" "$cache_path/sefaznet.zip"
  unzip $cache_path/sefaznet.zip -d ./cache
  executar "wine $cache_path/SefazNet_v1.24.0.3_instalador.exe /silent"
  sleep 1
  cp ~/.local/share/applications/wine/Programs/SEFAZ-PE/SEFAZNET/SEFAZNET.desktop "$desktop_path/Validadores"
  rm -Rf ~/.local/share/applications/wine/Programs/SEFAZ-PE
  cd "$desktop_path"
  rm -Rf SEFAZNET*
  chmod 777 -R "$desktop_path/Validadores"

  endInstall
fi

if [ "$acao" = "DIEF CE" ] ; then

  # Instalando complementos.
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40"

  # Baixando e executando programa principal
  download "http://servicos.sefaz.ce.gov.br/internet/download/dief/dief.exe"   "$cache_path/dief.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief.exe"

  # Movendo e limpando os arquivos de instalação.
  mv ~/.local/share/applications/wine/Programs/SEFAZ-CE/DIEF/DIEF.desktop "$desktop_path/Validadores/DIEF-CE.desktop"
  rm -Rf  ~/.local/share/applications/wine/Programs/SEFAZ-CE

  #Terminando instalação e notificando o usuário.
  endInstall

fi 

if [ "$acao" = "DIEF PI" ] ; then
  configurarWine
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks jet40"
  download "https://portal.sefaz.pi.gov.br/download/dief-v2-3-7/?wpdmdl=1768" "$cache_path/dief.exe"
  download "https://portal.sefaz.pi.gov.br/download/diefv2-3-7-atualizacao/?wpdmdl=1769" "./cache/dief_atualizacao.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief.exe /silent"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief_atualizacao.exe /silent"
  mv ~/.local/share/applications/wine/Programs/SEFAZPI/DIEF* "$desktop_path/Validadores"
  rm -Rf  ~/.local/share/applications/wine/Programs/SEFAZPI  
  download "https://cdn.projetusti.com.br/infra/facilitador/libs/MSSTDFMT.DLL" "$user_path/.wine32/drive_c/windows/system32/MSSTDFMT.DLL"
  env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine regsvr32 MSSTDFMT.DLL
  cd "$desktop_path"
  rm -Rf DAPISEF*
  endInstall
fi

if [ "$acao" = "DAPI MG" ] ; then
  win="win32"
  tricks="wine32"
  setWinePrefix "$win" "$tricks"
  configWine
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks gecko corefonts mdac28 jet40 msxml4"
  download "http://www.fazenda.mg.gov.br/empresas/declaracoes_demonstrativos/dapi/files/instalar.exe" "$cache_path/dapi.exe"
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dapi.exe"
  cp ~/.local/share/applications/wine/Programs/Secretaria\ da\ Fazenda\ -\ MG/DAPI/DAPISEF.desktop "$desktop_path/Validadores"
  rm -rf ~/.local/share/applications/wine/Programs/Secretaria*

  endInstall
fi

if [ "$acao" = "SINTEGRA" ]; then
  configurarWine
  download "https://cdn.projetusti.com.br/infra/facilitador/sintegra.exe" "$cache_path/sintegra.exe"
  executar "wine $cache_path/sintegra.exe /silent"
  sleep 1
  mv ~/.local/share/applications/wine/Programs/Validador\ Sintegra\ 2017/Validador\ Sintegra\ 2017.desktop "$desktop_path/Validadores"
  rm -Rf ~/.local/share/applications/wine/Programs/Validador*

  endInstall
fi

if [ "$acao" = "DAC AL" ]; then
  configurarWine
  download  "--header='Accept: text/html' --user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0' http://gcs.sefaz.al.gov.br/documentos/visualizarDocumento.action?key=t%2Bu8AZkwAeQ%3D" "$cache_path/InstalaDAC221012.exe"
  executar "wine $cache_path/InstalaDAC221012.exe"
  sleep 1
  cp ~/.local/share/applications/wine/Programs/Sefaz-AL/DAC/DAC.desktop  "$desktop_path/Validadores"
  cp "$desktop_path/TdiSefaz.desktop"  "$desktop_path/Validadores"
  rm -rf "$desktop_path/TdiSefaz.lnk"
  rm -rf "$desktop_path/DAC.lnk"
  rm -rf "$desktop_path/DAC.desktop"
  rm -Rf ~/.local/share/applications/wine/Programs/Sefaz-AL*

  endInstall
fi

if [ "$acao" = "DIEF CE" ] ; then # Precisa de banco de dados firebird.
  configurarWine
  download "https://servicos.sefaz.ce.gov.br/internet/download/dief/dief.exe" "$cache_path/dief.exe"
  env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine $cache_path/dief.exe /quiet
  sleep 3
  pkill fbguard
  pkill fbserver
  cp ~/.local/share/applications/wine/Programs/SEFAZ-CE/DIEF/DIEF.desktop "$desktop_path/Validadores"
  rm -rf  ~/.local/share/applications/wine/Programs/SEFAZ-CE*
  rm -rf "$desktop_path/DIEF.desktop"

  endInstall
fi 

if [ "$acao" = "Livro Eletronico GDF" ] ; then
  win="win64"
  tricks="dotnet"
  setWinePrefix "$win" "$stricks"
  configurarWine
  cd $HOME/
  download "http://www.livroeletronico.fazenda.df.gov.br/ValidadoresLFE/Validadoreslfe.exe" "$cache_path/Validadoreslfe.exe"
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" winetricks  dotnet452"
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" wine $cache_path/Validadoreslfe.exe"
  sleep 3
  cp ~/.local/share/applications/wine/Programs/Validadores/Validadores.desktop "$desktop_path/Validadores"
  rm -rf  ~/.local/share/applications/wine/Programs/Validadores*

  endInstall
fi 

if [ "$acao" = "DIEF MA" ] ; then
  win="win32"
  tricks="mdac28"
  setWinePrefix "$win" "$stricks"
  configurarWine
  download "http://downloads.sefaz.ma.gov.br/diefportal/Instalador_DIEF64_32bits.EXE" "$cache_path/Instalador_DIEF64_32bits.EXE"
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" winetricks  jet40 mdac28"
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" wine $cache_path/Instalador_DIEF64_32bits.EXE"
  sleep 1
  cd $HOME
  cp -f ~/.local/share/applications/wine/Programs/Programas\ SEFAZ-MA/DIEF64.desktop "$desktop_path/Validadores"
  cp -r "$HOME/.mdac28/drive_c/Documents and Settings/All Users/Dief64" "$HOME/.mdac28/drive_c/ProgramData/"
  rm -rf  ~/.local/share/applications/wine/Programs/Programas*
  rm -rf  "$desktop_path/DIEF64.desktop"

  endInstall
fi 

if [ "$acao" = "DES-PBH-ISS" ]; then # Ainda não consegui completar
  executar "apt install icedtea-netx"
  showMessage "Nas próximas mensagens, marque a única opção que aparecer na tela e depois clique no botão Later, Continuar e Executar."
  javaws http://bhissdigital.pbh.gov.br/des-ws/desapp/des.jnlp

  des_path=$(find "$desktop_path" -name "jws_app_shortcut_*")

  while [ ! -f "$des_path" ]; do
    sleep 2
    des_path=$(find "$desktop_path" -name "jws_app_shortcut_*")
  done

  mv "$des_path" "$desktop_path/Validadores"
  rm -Rf ~/.local/share/applications/jws_app_shortcut*

  endInstall
fi


if [ "$acao" = "GIA MT" ]; then
  win="win32"
  tricks="wine32"
  configurarWine
  download "www5.sefaz.mt.gov.br/documents/6071037/6426166/GIA_ICMS_307m_Completa_20120613.zip/5479ce2f-51ce-d471-1802-e5199cdd4807" "$cache_path/gia.zip"
  unzip $cache_path/gia.zip -d $cache_path
  cd /opt/projetus/facilitador/cache
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" wine $cache_path/GIA_ICMS_307m_Completa_20120613.exe"
  sleep 1
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" wine $cache_path/SETUP.exe /silent"
  sleep 1
  mv -f "$desktop_path/GIA 3.07.desktop" "$desktop_path/Validadores" 
  mkdir /opt/projetus/facilitador/cache/atualizacao
  download "http://www5.sefaz.mt.gov.br/documents/6071037/6426166/GIA_ICMS_307m_Atualizacao_20120613.zip/b8e63b35-06f9-a885-4fca-5a39f1c1420c" "$cache_path/atualizacao/gia_atualizacao.zip"
  unzip $cache_path/atualizacao/gia_atualizacao.zip -d $cache_path/atualizacao
  cd /opt/projetus/facilitador/cache/atualizacao
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" wine $cache_path/atualizacao/GIA_ICMS_307m_Atualizacao_20120613.exe"
  sleep 1
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" wine $cache_path/atualizacao/SETUP.exe /silent"
  sleep 1

  endInstall
fi

if [ "$acao" = "GIA RS" ] ; then
  win="win32"
  tricks="wine32"
  setWinePrefix "$win" "$tricks"
  download "https://www.sefaz.rs.gov.br/ASP/Download/Sat/Giamen/InstalaGIA9.exe" "$cache_path/gia9.exe"
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" winetricks jet40  mdac28"
  #configWine "$tricks"
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" wine $cache_path/gia9.EXE"
  sleep 1
  mkdir /opt/projetus/facilitador/cache/atualizacao
  download "https://www.sefaz.rs.gov.br/ASP/Download/Sat/Giamen/AtualizaGia9.exe" "$cache_path/atualizacao/AtualizaGia9.exe"
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" wine $cache_path/atualizacao/AtualizaGia9.EXE"
  rm -rf  "~/.local/share/applications/wine/Programs/GIA 9"
  mv -f "$desktop_path/GIA 9.desktop" "$desktop_path/Validadores"
  rm -rf  "$desktop_path/GIA 9.lnk"

  endInstall
fi 

if [ "$acao" = "DIEF PA" ] ; then # instala mais não inicia erro de comunicação de java

  # Limpeza da versao antiga
  rm -rf $user_path/.wine/drive_c/DIEF20*

  # Instalação do app via wine
  download "http://www.sefa.pa.gov.br/arquivos/downloads/dief/2022/DIEF2022.2.0.msi" "$cache_path/DIEF2022.msi"
  cd $cache_path
  executar "wine msiexec /i DIEF2022.msi /quite /qn"
  sleep 1

  # Download da JRE versão windows
  cd $user_path/.wine/drive_c/DIEF2022.2.0/
  executar "wget  https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u252-b09.1/OpenJDK8U-jre_x86-32_windows_hotspot_8u252b09.zip " "Baixando JRE"
  mv OpenJDK8U-jre_x86-32_windows_hotspot_8u252b09.zip jre.zip
  unzip jre.zip
  mv jdk8u252-b09-jre jre
  rm -rf jre.zip

  cd "$desktop_path/"
  mv DIEF2022.2.0.desktop "$desktop_path/Validadores/DIEF-PA-2022.2.0.desktop"
  rm -rf DIEF20*.*

  endInstall
fi 

if [ "$acao" = "GIM ICMS PB" ] ; then 
  win="win32"
  tricks="wine32"
  configurarWine
  setWinePrefix "$win" "$tricks"
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" winetricks mdac28 jet40" # Nessa ordem
  sleep 1
  download "http://www.sefaz.pb.gov.br/ser/images/docs/downloads/GIM/InstalaGimSREPB-Ver_2473.exe"  "$cache_path/gimsrepb.exe"
  executar "env WINEARCH="$win" WINEPREFIX=$HOME/."$tricks" wine  $cache_path/gimsrepb.exe"
  sleep 1
  cd $HOME
  mv -f "$desktop_path/Gim SRE-PB.desktop" "$desktop_path/Validadores"
  rm -rf  ~/.local/share/applications/wine/Programs/SRE-PB
  rm -rf  "$desktop_path/Gim SRE-PB.lnk"

  endInstall
fi 

if [ "$acao" = "SEDIF-SN" ] ; then 
  configurarWine
  # Instalando complementos.
  executar "env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks dotnet45"

  # Baixando e executando programa principal
  download "http://www.fazenda.mg.gov.br/empresas/declaracoes_demonstrativos/DeSTDA_SEDIF-SN/files/sedif_Setup1.0.6.00.exe"   "$cache_path/sedif.exe"
  cd "$cache_path"
  
  # Execuntando o executavel para instalação 
  executar "wine $cache_path/sedif.exe"
  
  # Tempo para serem criados os atalhos antes de copialos
  sleep1

  # Copiando o atalho para a pasta de Validadores
  cp ~/.local/share/applications/wine/Programs/SimplesNacional/SEDIF.desktop "$desktop_path/Validadores"
  

  endInstall
fi 

if [ "$acao" = "DMED" ] ; then 

 configurarWine

  Baixando
  download "https://servicos.receita.fazenda.gov.br/publico/programas/Dmed/2023/Dmed2023Win64v1.0.exe"   "$cache_path/Dmed.exe"
  cd "$cache_path"

  #Execuntando o executavel para instalação 
  executar "wine $cache_path/Dmed.exe /mode silent"

  #Tempo para serem criados os atalshos antes de copialos
  sleep 1

  #Copiando o atalho para a pasta de Validadores
  mv -f "$desktop_path/Dmed2023.desktop" "$desktop_path/Validadores"
  
  endInstall
fi 

