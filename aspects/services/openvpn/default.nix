{
  nixos = {
    services.openvpn.servers.home = {
      autoStart = true;
      config = ''
        port 1194
        proto udp
        dev tun
        topology subnet

        ca ${./pki.secret/ca.crt}
        cert ${./pki.secret/server.crt}
        key ${./pki.secret/server.key}
        dh none
        tls-crypt ${./pki.secret/ta.key}
        tls-version-min 1.2

        server 10.8.0.0 255.255.255.0
        max-clients 16

        push "redirect-gateway def1 bypass-dhcp"
        push "dhcp-option DNS 1.1.1.1"
        push "dhcp-option DNS 1.1.1.1"
        push "block-outside-dns"

        keepalive 10 120
        persist-key
        persist-tun
        explicit-exit-notify 1

        user nobody
        group nobody
      '';
    };

    networking.firewall.allowedUDPPorts = [1194];

    networking.nat = {
      enable = true;
      internalInterfaces = ["tun0"];
      externalInterface = "enp0s6";
    };
  };

  persist.directories = ["/var/lib/openvpn"];
}
