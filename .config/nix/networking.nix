{ ... }: {
  networking.wg-quick.interfaces.spl = {
    address = [
      "10.0.0.1/32"
      "fd00::1/128"
    ];
    autostart = false;
    dns = [
      "fd2c:c142:5e23::ac0f:c3ff:fe1c:c61b"
      "fd2c:c142:5e23:0:216:3eff:fe04:fb6e"
      "192.168.0.100"
      "192.168.0.3"
    ];
    peers = [
      {
        allowedIPs = [
          "fd2c:c142:5e23::/64"
          "fd00::/64"
          "192.168.0.0/16"
          "10.0.0.0/24"
        ];
        endpoint = "speely.net:51820";
        persistentKeepalive = 25;
        publicKey = "wei6JspjityhJLQ2j1MRO4mPUEEYypDAI4tcL2mIjEY=";
      }
    ];
    privateKeyFile = "/etc/wireguard/spl.key";
  };
}
