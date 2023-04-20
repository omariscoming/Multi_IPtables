function my_function {
  local server_ip="$1"
  local ds_server_ip="$2"
  local username="$3"
  local password="$4"
  
  ssh_command="sudo sysctl net.ipv4.ip_forward=1;
                sudo iptables -t nat -A PREROUTING -p UDP --dport 22 -j DNAT --to-destination $server_ip;
                sudo iptables -t nat -A PREROUTING -j DNAT --to-destination $ds_server_ip;
                sudo iptables -t nat -A POSTROUTING -j MASQUERADE"

  sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username@$server_ip" "$ssh_command"
}
sudo apt-get install sshpass jq -y
my_function "MainServerIpHere1" "destinationServerIpHere1" "USERNAME" "PASSWORD"
my_function "MainServerIpHere2" "destinationServerIpHere2" "USERNAME" "PASSWORD"
my_function "MainServerIpHere3" "destinationServerIpHere3" "USERNAME" "PASSWORD"

